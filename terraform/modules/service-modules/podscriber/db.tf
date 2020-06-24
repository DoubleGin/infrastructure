resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_compute_global_address" "db_private_ip" {
  name          = "db-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_id
}

resource "google_service_networking_connection" "db_private_vpc_connection" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.db_private_ip.name]
}

resource "google_sql_database_instance" "instance" {
  name             = "podscriber-${var.environment}-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_11"
  region           = var.region
  settings {
    tier = var.db_instance_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_id
    }
  }
  depends_on = [google_service_networking_connection.db_private_vpc_connection]
}

resource "google_sql_database" "database" {
  name     = "podscriber"
  instance = google_sql_database_instance.instance.name
}

resource "random_password" "podscriber_web_db_pw" {
  length = 20
}

resource "google_sql_user" "podscriber_web" {
  name     = "podscriber-web"
  instance = google_sql_database_instance.instance.name
  password = random_password.podscriber_web_db_pw.result
}
