resource "kubernetes_config_map" "podscriber_web" {
  metadata {
    name      = "podscriber-web"
    namespace = var.k8s_namespace
  }

  data = {
    WEB_DB_HOST                     = google_sql_database_instance.instance.ip_address.0.ip_address
    WEB_DB_USER                     = google_sql_user.podscriber_web.name
    WEB_DB_NAME                     = google_sql_database.database.name
    WEB_REDIS_HOST                  = var.redis_service["host"]
    WEB_REDIS_PORT                  = var.redis_service["port"]
    WEB_REDIS_DB_ID                 = "0"
    WEB_MEILI_HOST                  = "meilisearch.meilisearch.svc.cluster.local"
    WEB_MEILI_PORT                  = 7700
    WEB_PODCAST_MEDIA_GCS_BUCKET    = google_storage_bucket.buckets["podcasts"].name
    WEB_EXCERPT_MEDIA_GCS_BUCKET    = google_storage_bucket.buckets["excerpts"].name
    WEB_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.buckets["transcripts"].name
    WEB_EXCERPT_MEDIA_S3_BUCKET     = aws_s3_bucket.excerpts.bucket
    WEB_TRANSCRIPT_MEDIA_S3_BUCKET  = aws_s3_bucket.transcripts.bucket
    WEB_AWS_S3_BUCKET_REGION        = "us-west-2"
    # when empty, use real S3, when specified, use local S3 (minio)
    WEB_AWS_S3_ENDPOINT_URL = ""
    WEB_DEBUG               = "false"
    WEB_LOG_LEVEL           = "INFO"
    WEB_DJANGO_LOG_LEVEL    = "INFO"
    # settings module will fetch credentials from comma separated list of secret mgr secrets here
    WEB_SECRET_MANAGER_SECRET_NAMES = "meili-master-key"
  }
}

resource "random_password" "django_secret_key" {
  length = 20
}

data "google_secret_manager_secret_version" "appoptics_svc_key" {
  secret = "appoptics-service-key-podscriber-web"
}

# redis secret is generated randomly by the redis helm chart, here we just read
# it out and cc it over to the podscriber namespace

data "kubernetes_secret" "redis" {
  metadata {
    name = "redis"
    namespace = "redis"
  }
}

resource "kubernetes_secret" "podscriber_web" {
  metadata {
    name      = "podscriber-web"
    namespace = var.k8s_namespace
  }

  data = {
    WEB_DB_PASS                  = random_password.podscriber_web_db_pw.result
    WEB_SECRET_KEY               = random_password.django_secret_key.result
    WEB_AWS_S3_ACCESS_KEY_ID     = aws_iam_access_key.podscriber.id
    WEB_AWS_S3_SECRET_ACCESS_KEY = aws_iam_access_key.podscriber.secret
    APPOPTICS_SERVICE_KEY        = data.google_secret_manager_secret_version.appoptics_svc_key.secret_data
  }
}

resource "kubernetes_config_map" "podscriber_worker" {
  metadata {
    name      = "podscriber-worker"
    namespace = var.k8s_namespace
  }

  data = {
    WORKER_REDIS_HOST                  = var.redis_service["host"]
    WORKER_REDIS_PORT                  = var.redis_service["port"]
    WORKER_REDIS_DB_ID                 = "0"
    WORKER_MEILI_HOST                  = "meilisearch.meilisearch.svc.cluster.local"
    WORKER_MEILI_PORT                  = 7700
    WORKER_PODSCRIBER_WEB_HOST         = "podscriber-web.podscriber.svc.cluster.local"
    WORKER_PODCAST_MEDIA_GCS_BUCKET    = google_storage_bucket.buckets["podcasts"].name
    WORKER_EXCERPT_MEDIA_GCS_BUCKET    = google_storage_bucket.buckets["excerpts"].name
    WORKER_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.buckets["transcripts"].name
    WORKER_EXCERPT_MEDIA_S3_BUCKET     = aws_s3_bucket.excerpts.bucket
    WORKER_TRANSCRIPT_MEDIA_S3_BUCKET  = aws_s3_bucket.transcripts.bucket
    WORKER_AWS_S3_ENDPOINT_URL         = ""
    WORKER_AWS_S3_BUCKET_REGION        = "us-west-2"
    # django settings module will fetch credentials from comma separated list of secret mgr secrets here
    WORKER_SECRET_MANAGER_SECRET_NAMES = "podscriber-worker,meili-master-key"
  }
}

resource "kubernetes_secret" "podscriber_worker" {
  metadata {
    name      = "podscriber-worker"
    namespace = var.k8s_namespace
  }

  data = {
    WORKER_REDIS_PASS               = data.kubernetes_secret.redis.data["redis-password"]
    WORKER_AWS_S3_ACCESS_KEY_ID     = aws_iam_access_key.podscriber.id
    WORKER_AWS_S3_SECRET_ACCESS_KEY = aws_iam_access_key.podscriber.secret
  }
}
