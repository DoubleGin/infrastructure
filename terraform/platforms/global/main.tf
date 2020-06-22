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
