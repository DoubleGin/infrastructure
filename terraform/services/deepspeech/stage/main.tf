module "workload" {
  source = "../../../modules/service-modules/workload"
  name   = "deepworker"
}

module "deepworker" {
  source        = "../../../modules/service-modules/deepworker"
  environment   = "stage"
  region        = var.region
  k8s_namespace = module.workload.k8s_namespace
  gcp_sa_email  = module.workload.gcp_sa_email
  redis_service = data.terraform_remote_state.podscriber.outputs.redis_service
}
