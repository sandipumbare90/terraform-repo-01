terraform {
  backend "gcs" {
    bucket                      = "gcs-bucket-for-backend-state-files1"
    prefix                      = "terraform-1/state"
    impersonate_service_account = "jenkins-sa-cicd@devops-engineer-123.iam.gserviceaccount.com"
  }
}

provider "google" {
  project                     = "mercurial-weft-426905-v8"
  region                      = "us-central1"
  zone                        = "us-central1-a"
  impersonate_service_account = "jenkins-sa-cicd@devops-engineer-123.iam.gserviceaccount.com"
}
