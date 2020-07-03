resource "kubernetes_config_map" "deepworker" {
  metadata {
    name      = "deepworker"
    namespace = var.k8s_namespace
  }

  data = {
    DEEPWORKER_REDIS_HOST                             = var.redis_service["host"]
    DEEPWORKER_REDIS_PORT                             = var.redis_service["port"]
    DEEPWORKER_REDIS_DB_ID                            = "0"
    DEEPWORKER_PODSCRIBER_WEB_HOST                    = "podscriber-web.podscriber.svc.cluster.local"
    DEEPWORKER_DEEPSPEECH_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.deepspeech_transcripts.name
    #DEEPWORKER_PODCAST_MEDIA_GCS_BUCKET    = google_storage_bucket.podcasts.name
    #DEEPWORKER_EXCERPT_MEDIA_GCS_BUCKET    = google_storage_bucket.excerpts.name
    #DEEPWORKER_TRANSCRIPT_MEDIA_GCS_BUCKET = google_storage_bucket.transcripts.name
    # settings module will fetch credentials blob from this google secret manager secret at startup
    #DEEPWORKER_SECRET_MANAGER_SECRET_NAME = "deepworker"
  }
}
