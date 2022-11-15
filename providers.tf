terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.41.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.41.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = "1.3.4"
}