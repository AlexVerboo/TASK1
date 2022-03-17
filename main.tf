#DECalracion de service account
resource "google_service_account" "sa_servicio_task1" {
  account_id   = "sa-servicio-task1"
}
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list","iam.roles.create", "iam.roles.delete","pubsub.schemas.get","pubsub.schemas.get","pubsub.schemas.list","pubsub.schemas.validate","pubsub.snapshots.get","pubsub.snapshots.list","pubsub.subscriptions.get","pubsub.subscriptions.list","pubsub.topics.get","pubsub.topics.list","resourcemanager.projects.get","serviceusage.quotas.get","serviceusage.services.get","serviceusage.services.list"]
}
#permisos para SA
resource "google_project_iam_binding" "pubsub_iam" {
    project="alex-verboonen-2022-run-5"
    role = "roles/pubsub.viewer"
    members = ["serviceAccount:${google_service_account.sa_servicio_task1.email}"]
}
resource "google_project_iam_binding" "storage_iam" {
    project="alex-verboonen-2022-run-5"
    role = "roles/storage.admin"
    members = ["serviceAccount:${google_service_account.sa_servicio_task1.email}"]
}
resource "google_project_iam_binding" "custom_iam" {
    project="alex-verboonen-2022-run-5"
    role = "projects/alex-verboonen-2022-run-5/roles/myCustomRole"
    members = ["serviceAccount:${google_service_account.sa_servicio_task1.email}"]
}
#Declaracion para PUBSUB y Scheduler
resource "google_pubsub_topic" "topic" {
  name = "job-topic"
}
#Declaracion de insancia
resource "google_compute_instance" "task1_instance" {
  name         = "instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.sa_servicio_task1.email
    scopes = ["cloud-platform"]
  }
}
#declaracion de bucket
resource "google_storage_bucket" "task1_bucket" {
  name          = "bucket-alexv-task1"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = false
}
resource "google_cloud_scheduler_job" "job" {
  name        = "test-job"
  description = "test job"
  region         = "us-central1"
  schedule    = "*/1 * * * *"
  time_zone   = "America/Mexico_City"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.topic.id
    data       = base64encode("data")
  }
}

resource "google_pubsub_subscription" "example" {
  name  = "example-subscription"
  topic = google_pubsub_topic.topic.name

  labels = {
    foo = "bar"
  }

  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }

  enable_message_ordering    = false
}