data "terraform_remote_state" "podscriber" {
  backend = "gcs"
  config = {
    bucket = "oddmark-stage-tf-state"
    prefix = "services/podscriber"
  }
}
