terraform {
backend "gcs" {
    bucket = "gcs-bucket-for-backend-state-files"
    prefix = "terraform-1/state"
    impersonate_service_account = "jenkins-sa-cicd@devops-engineer-123.iam.gserviceaccount.com"
}
}

provider "google" {
	project = "devops-engineer-123"
	region = "us-central1"
	impersonate_service_account = "jenkins-sa-cicd@devops-engineer-123.iam.gserviceaccount.com"
}
