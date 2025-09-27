terraform {
  backend "gcs" {
    bucket = "jmeter-sandbox-tfstate"
  }
  required_providers {
    google = {
      version = "~> 6.12.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.7.2"
    }
  }

  required_version = ">= 1.0.0"
}
provider "google" {
  project = "sandbox-jmeter"
  region  = "asia-northeast1"
}
