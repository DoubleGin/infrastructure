/* because "project" means something else in google land */
variable "system_name" {
  default = "oddmark"
}

variable "required_apis" {
  default = [
    "iam.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "redis.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}
