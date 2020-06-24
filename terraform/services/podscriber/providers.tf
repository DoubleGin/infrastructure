provider "google" {
  project = "oddmark-stage"
  region  = "us-central1"
}

provider "google-beta" {
  project = "oddmark-stage"
  region  = "us-central1"
}

provider "aws" {
  profile = "doublegin"
  region  = "us-west-2"
}

provider "kubernetes" {
  config_context = "gke_oddmark-stage_us-central1-a_oddmark-stage"
}
