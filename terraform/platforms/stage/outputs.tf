output "redis_service" {
  value = module.redis.redis_service
}

output "network_id" {
  value = module.vpc.network["network"].id
}
