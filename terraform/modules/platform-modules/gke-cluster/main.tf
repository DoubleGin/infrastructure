data "google_project" "project" {}

resource "google_container_cluster" "cluster" {
  name     = "${var.name}-${var.environment}"
  location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_name
  subnetwork = var.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_ip_range_name
    services_secondary_range_name = var.services_ip_range_name
  }

  min_master_version = "1.16.9-gke.6"

  workload_identity_config {
    identity_namespace = "${data.google_project.project.project_id}.svc.id.goog"
  }

  lifecycle {
    ignore_changes = [
      min_master_version
    ]
  }
}
