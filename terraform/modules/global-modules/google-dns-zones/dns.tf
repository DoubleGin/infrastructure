resource "google_dns_managed_zone" "prod" {
  project  = var.prod_project
  name     = "oddmark"
  dns_name = "oddmark.app."
}

resource "google_dns_managed_zone" "stage" {
  project  = var.stage_project
  name     = "oddmark"
  dns_name = "stage.oddmark.app."
}

resource "google_dns_record_set" "stage_delegation" {
  project      = var.prod_project
  name         = "stage.oddmark.app."
  type         = "NS"
  ttl          = 60
  managed_zone = google_dns_managed_zone.prod.name
  rrdatas      = google_dns_managed_zone.stage.name_servers
}

resource "google_dns_record_set" "improvmx_mail_fwd" {
  project      = var.prod_project
  name         = "oddmark.app."
  type         = "TXT"
  ttl          = 300
  managed_zone = google_dns_managed_zone.prod.name
  rrdatas      = ["v=spf1 include:spf.improvmx.com ~all"]
}

resource "google_dns_record_set" "improvmx_mail_receive" {
  project      = var.prod_project
  name         = "oddmark.app."
  type         = "MX"
  ttl          = 300
  managed_zone = google_dns_managed_zone.prod.name
  rrdatas = [
    "10 mx1.improvmx.com.",
    "20 mx2.improvmx.com.",
  ]
}
