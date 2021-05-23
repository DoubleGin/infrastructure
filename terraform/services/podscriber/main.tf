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
  gcp_sa_email     = module.workload.gcp_sa_email
  network_id       = data.terraform_remote_state.platform.outputs.network_id
  redis_service    = var.redis_service
  bucket_names     = var.bucket_names
  secret_names     = var.secret_names
}
