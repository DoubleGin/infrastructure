/* because "project" means something else in google land */
variable "system_name" {
  default = "oddmark"
}

variable "required_apis" {
  default = [
    "iam.googleapis.com",
    "dns.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "redis.googleapis.com",
    "servicenetworking.googleapis.com",
    "secretmanager.googleapis.com",
  ]
}
