provider "google" {
    project = "devops-476806" 
    credentials = file("/var/lib/jenkins/file.json")
}
resource "google_compute_instance" "instance1" {
    name = "vm-2"
    zone =  "us-west1-b" 
    machine_type = "e2-micro"
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"        
      }
    }
    network_interface {
        network = "default"
        access_config {
           //
        }
    }
    metadata = {
      ssh-keys = "sivadevialuri65:${file("/var/lib/jenkins/.ssh/id_ed25519.pub")}"
    }
}

resource "local_file" "file1" {
  content  = "sivadevialuri65@${google_compute_instance.instance1.network_interface[0].access_config[0].nat_ip}"
  filename = "/var/lib/jenkins/workspace/ip.txt"
}
