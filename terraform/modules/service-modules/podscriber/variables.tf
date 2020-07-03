variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "location" {
  type = string
}

variable "db_instance_tier" {
  type = string
}

variable "k8s_namespace" {
  type = string
}

variable "gcp_sa_email" {
  type = string
}

variable "network_id" {
  type = string
}

variable "redis_service" {
  type = map(string)
}
