provider "google" {
  project = "myfirstprojectterraform-405020"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "static-site" {
  name          = "my-terraform-bucket-28"
  location      = "us-central1"
  force_destroy = true

  uniform_bucket_level_access = true
}


resource "google_compute_instance" "my_instance" {
  name         = "my-terraform-instance"
  machine_type = "n1-standard-1"  
  zone         = "us-central1-a" 

  tags = ["hohoho"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
  }
}

resource "google_sql_database_instance" "my_sql_terraform" {
  name             = "my-sql-terraform"
  database_version = "POSTGRES_13"
  project          = "myfirstprojectterraform-405020"
  region           = "us-central1"  

settings {
    tier = "db-f1-micro"  # Change to your desired tier
  }
}

resource "google_sql_database" "firstDatabaseTerraform" {
    name = "dareit"
    instance = google_sql_database_instance.my_sql_terraform.name
}

resource "google_sql_user" "firstDatabaseTerraform_user" {
    name = "dareit_user"
    instance = google_sql_database_instance.my_sql_terraform.name
    password = "changeme"
}
 