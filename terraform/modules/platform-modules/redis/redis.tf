resource "google_redis_instance" "rq" {
  name               = "rq"
  memory_size_gb     = 1
  location_id        = var.location
  authorized_network = var.network_id
}
