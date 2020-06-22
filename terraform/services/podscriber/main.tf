module "workload" {
  source = "../../modules/service-modules/workload"
  name   = "podscriber"
}

module "podscriber" {
  source           = "../../modules/service-modules/podscriber"
  environment      = "stage"
  region           = var.region
  location         = var.location
  db_instance_tier = var.db_instance_tier
  k8s_namespace    = module.workload.k8s_namespace
  network_id       = data.google_compute_network.main.id
}
