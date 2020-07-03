data "terraform_remote_state" "platform" {
  backend = "gcs"
  config = {
    bucket = "oddmark-stage-tf-state"
  }
}
