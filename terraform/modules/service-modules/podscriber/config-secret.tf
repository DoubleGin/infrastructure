resource "kubernetes_config_map" "podscriber_web" {
  metadata {
    name      = "podscriber-web"
    namespace = var.k8s_namespace
  }

  data = {
    WEB_DB_HOST                     = google_sql_database_instance.instance.ip_address.0.ip_address
    WEB_DB_USER                     = google_sql_user.podscriber_web.name
    WEB_DB_NAME                     = google_sql_database.database.name
    WEB_REDIS_HOST                  = google_redis_instance.rq.host
    WEB_REDIS_PORT                  = google_redis_instance.rq.port
    WEB_REDIS_DB_ID                 = "0"
    WEB_PODCAST_MEDIA_GCS_BUCKET    = google_storage_bucket.podcasts.name
    WEB_EXCERPT_MEDIA_GCS_BUCKET    = google_storage_bucket.excerpts.name
    WEB_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.transcripts.name
    #TODO: fix
    WEB_PODCAST_MEDIA_S3_BUCKET    = "oddmark-podcasts-stage"
    WEB_EXCERPT_MEDIA_S3_BUCKET    = "oddmark-excerpts-stage"
    WEB_TRANSCRIPT_MEDIA_S3_BUCKET = "oddmark-transcriptions-stage"
    WEB_AWS_S3_BUCKET_REGION       = "us-east-1"
    WEB_AWS_S3_ENDPOINT_URL        = ""
    WEB_AWS_S3_ACCESS_KEY_ID       = "foo"
    WEB_AWS_S3_SECRET_ACCESS_KEY   = "bar"
    WEB_DEBUG                      = "false"
    WEB_LOG_LEVEL                  = "INFO"
    WEB_DJANGO_LOG_LEVEL           = "INFO"
  }
}

resource "random_password" "django_secret_key" {
  length = 20
}

resource "kubernetes_secret" "podscriber_web" {
  metadata {
    name      = "podscriber-web"
    namespace = var.k8s_namespace
  }

  data = {
    #TODO integrate with secrets manager
    WEB_DB_PASS    = random_password.podscriber_web.result
    WEB_SECRET_KEY = random_password.django_secret_key.result
    #TODO: AWS IAM creds
  }
}

resource "kubernetes_config_map" "podscriber_worker" {
  metadata {
    name      = "podscriber-worker"
    namespace = var.k8s_namespace
  }

  data = {
    WORKER_REDIS_HOST                  = google_redis_instance.rq.host
    WORKER_REDIS_PORT                  = google_redis_instance.rq.port
    WORKER_REDIS_DB_ID                 = "0"
    WORKER_PODCAST_MEDIA_GCS_BUCKET    = google_storage_bucket.podcasts.name
    WORKER_EXCERPT_MEDIA_GCS_BUCKET    = google_storage_bucket.excerpts.name
    WORKER_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.transcripts.name
    WORKER_SECRET_MANAGER_SECRET_NAME  = "podscriber-worker"
  }
}

resource "kubernetes_secret" "podscriber_worker" {
  metadata {
    name      = "podscriber-worker"
    namespace = var.k8s_namespace
  }

  data = {
    WORKER_APPOPTICS_API_TOKEN = "foo"
  }
}
