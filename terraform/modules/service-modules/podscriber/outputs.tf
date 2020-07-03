output "redis_service" {
  value = {
    host = google_redis_instance.rq.host,
    port = google_redis_instance.rq.port
  }
}
