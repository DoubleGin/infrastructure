#GCP account project config
module "stage_project" {
  source      = "../../modules/global-modules/gcp-project/"
  name        = var.system_name
  apis        = var.required_apis
  environment = "stage"
}

module "prod_project" {
  source      = "../../modules/global-modules/gcp-project/"
  name        = var.system_name
  apis        = var.required_apis
  environment = "prod"
}

# AWS Route53 Zones
module "dns_zones" {
  source = "../../modules/global-modules/dns-zones/"
}

module "google_dns_zones" {
  source        = "../../modules/global-modules/google-dns-zones/"
  stage_project = module.stage_project.name
  prod_project  = module.prod_project.name
}
