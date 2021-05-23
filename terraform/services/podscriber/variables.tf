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

variable "secret_names" {
  default = [
    "podscriber-worker",
    "meili-master-key"
  ]
}

variable "redis_service" {
  # defaulted via the redis helm chart
  default = {
    "host": "redis-master.redis.svc.cluster.local",
    "port": "6379"
  }
}
