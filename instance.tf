resource "google_compute_instance" "terraform-instance" {
	name = "client-node-1"
	machine_type = "e2-medium"
	zone = "us-central1-a"
	labels = {
	  team = "devops"
	  depart = "hr"
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
	lifecycle {
          ignore_changes = [attached_disk]
                  } 

}

#------Extra Disk to VM Instance-----#

resource "google_compute_disk" "data-disk-01" {
	name = "data-disk-01"
	zone = "us-central1-a"
	size = "20"
	type = "pd-standard"
}

#------Attach Disk-----#

resource "google_compute_attached_disk" "disk-attach-policy" {
	disk = google_compute_disk.data-disk-01.id
	instance = google_compute_instance.terraform-instance.name
	zone = "us-central1-a"
}

#------Snapshot Resource Policy Creation-----#

resource "google_compute_resource_policy" "my-policy-for-snapshot-creation" {
	name = "first-policy-for-snapshot-cre"
	region = "us-central1"
	snapshot_schedule_policy {
	  schedule {
	    daily_schedule {
	      days_in_cycle = 1
	      start_time = "00:00"
                           }
                   }
	  retention_policy {
	    max_retention_days = 3
            on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
                          }  
              }
}

#-------Resource Policy Attachment------#

resource "google_compute_disk_resource_policy_attachment" "my-first-policy-attachment" {
	name = google_compute_resource_policy.my-policy-for-snapshot-creation.name
	disk = google_compute_disk.data-disk-01.name
	zone = "us-central1-a"
}
