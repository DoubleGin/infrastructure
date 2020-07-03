variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "gcp_sa_email" {
  type = string
}

variable "k8s_namespace" {
  type = string
}

variable "redis_service" {
  type = map(string)
}
