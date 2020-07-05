data "terraform_remote_state" "platform" {
  backend = "gcs"
  config = {
    bucket = "oddmark-stage-tf-state"
  }
}

data "terraform_remote_state" "podscriber" {
  backend = "gcs"
  config = {
    bucket = "oddmark-stage-tf-state"
    prefix = "services/podscriber"
  }
}
