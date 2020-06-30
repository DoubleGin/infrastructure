data "google_secret_manager_secret_version" "slack_token" {
  project = "ace-botany-280906" # root / global project
  secret  = "slack-notification-token"
}

resource "google_monitoring_notification_channel" "doublegin" {
  display_name = "doublegin"
  type         = "slack"
  labels = {
    "channel_name" = "#doublegin"
  }
  sensitive_labels {
    auth_token = data.google_secret_manager_secret_version.slack_token.secret_data
  }
}
