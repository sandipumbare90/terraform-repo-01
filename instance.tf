resource "google_compute_instance" "terraform-instance" {
	name = "client-node-1"
	machine_type = "e2-medium"
	zone = "us-central1-a"
	labels = {
	  team = "GCP"
	}
	boot_disk {
          initialize_params {
          image = "ubuntu-os-cloud/ubuntu-2204-lts"
                             }
                   }
	network_interface {
	  network = "projects/devops-engineer-123/global/networks/my-vpc-01"
	  subnetwork = "projects/devops-engineer-123/regions/us-central1/subnetworks/subnet-01"
        access_config {
                    }
}


}
