/* because "project" means something else in google land */
variable "system_name" {
  default = "oddmark"
}

variable "environment" {
  default = "prod"
}

variable "location" {
  default = "us-central1-a"
}

variable "region" {
  default = "us-central1"
}

variable "k8s_version" {
  default = "1.17.17-gke.1101"
}
