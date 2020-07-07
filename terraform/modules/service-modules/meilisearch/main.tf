resource "random_password" "master_key" {
  length  = 25
  special = true
}

resource "kubernetes_namespace" "meilisearch" {
  metadata {
    name = "meilisearch"
  }
}

resource "kubernetes_secret" "meilisearch" {
  metadata {
    name      = "meilisearch"
    namespace = "meilisearch"
  }

  data = {
    MEILI_MASTER_KEY = random_password.master_key.result
  }

  depends_on = [
    kubernetes_namespace.meilisearch
  ]
}

resource "google_secret_manager_secret" "master_key" {
  secret_id = "meili-master-key"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "master_key" {
  secret = google_secret_manager_secret.master_key.id

  secret_data = random_password.master_key.result
}
