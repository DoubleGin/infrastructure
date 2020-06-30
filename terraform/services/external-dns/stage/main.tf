module "workload" {
  source = "../../../modules/service-modules/workload"
  name   = "external-dns"
}

module "external_dns" {
  source       = "../../../modules/service-modules/external-dns"
  gcp_sa_email = module.workload.gcp_sa_email
}
