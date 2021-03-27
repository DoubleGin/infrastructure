data "google_project" "project" {}

module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 2.3"
  network_name = "${var.system_name}-${var.environment}"
  project_id   = data.google_project.project.name
  subnets = [
    {
      subnet_name           = "main"
      subnet_ip             = "10.10.0.0/16"
      subnet_region         = var.region
      subnet_private_access = true
    },
  ]

  secondary_ranges = {
    main = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.16.0.0/14"
      },
      {
        range_name    = "services",
        ip_cidr_range = "10.20.0.0/20"
      },
    ]
  }
}

module "cluster" {
  source                 = "../../modules/platform-modules/gke-cluster"
  name                   = var.system_name
  environment            = var.environment
  location               = var.location
  region                 = var.region
  k8s_version            = var.k8s_version
  network_name           = module.vpc.network["network"].name
  subnet_name            = "main"
  pod_ip_range_name      = "pods"
  services_ip_range_name = "services"
}

module "registry" {
  source                        = "../../modules/platform-modules/container-registry"
  name                          = var.system_name
  environment                   = var.environment
  cluster_service_account_email = module.cluster.service_account_email
}
