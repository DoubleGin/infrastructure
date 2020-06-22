resource "google_container_node_pool" "preemptible" {
  name     = "preemptible"
  location = var.location
  cluster  = google_container_cluster.cluster.name

  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 4
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible     = true
    machine_type    = "e2-standard-2"
    service_account = google_service_account.cluster_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
