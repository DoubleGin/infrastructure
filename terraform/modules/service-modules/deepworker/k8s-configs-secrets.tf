resource "kubernetes_config_map" "deepworker" {
  metadata {
    name      = "deepworker"
    namespace = var.k8s_namespace
  }

  data = {
    WORKER_REDIS_HOST                             = var.redis_service["host"]
    WORKER_REDIS_PORT                             = var.redis_service["port"]
    WORKER_REDIS_DB_ID                            = "0"
    WORKER_PODSCRIBER_WEB_HOST                    = "podscriber-web.podscriber.svc.cluster.local"
    WORKER_DEEPSPEECH_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.deepspeech_transcripts.name
    WORKER_DEEPSPEECH_VERSION                     = "0.7.4"
    WORKER_PODCAST_MEDIA_GCS_BUCKET               = var.podcast_media_gcs_bucket
    # settings module will fetch credentials blob from this google secret manager secret at startup
    #WORKER_SECRET_MANAGER_SECRET_NAME = "deepworker"
  }
}
