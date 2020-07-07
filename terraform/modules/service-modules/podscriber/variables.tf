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

variable "bucket_names" {
  description = "list of gcs buckets to create and grant podscriber service account full access to"
  type        = list(string)
}

variable "secret_names" {
  description = "list of google secret manager secrets to grant podscriber service account read access to"
  type        = list(string)
}

variable "redis_service" {
  type = map(string)
}
