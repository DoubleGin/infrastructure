variable "location" {
  default = "us-central1-a"
}

variable "region" {
  default = "us-central1"
}

variable "db_instance_tier" {
  default = "db-f1-micro"
}

variable "bucket_names" {
  default = [
    "transcripts",
    "podcasts",
    "excerpts",
  ]
}
