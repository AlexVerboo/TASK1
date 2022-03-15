resource "google_service_account" "sa_servicio_task1" {
  account_id   = "sa-servicio-task1"
}
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = "myCustomRole"
  title       = "My Custom Role"
  description = "A description"
  permissions = ["iam.roles.list","iam.roles.create", "iam.roles.delete","pubsub.schemas.get","pubsub.schemas.get","pubsub.schemas.list","pubsub.schemas.validate","pubsub.snapshots.get","pubsub.snapshots.list","pubsub.subscriptions.get","pubsub.subscriptions.list","pubsub.topics.get","pubsub.topics.list","resourcemanager.projects.get","serviceusage.quotas.get","serviceusage.services.get","serviceusage.services.list"]
}

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



resource "google_pubsub_topic" "topic" {
  name = "job-topic"
}

resource "google_cloud_scheduler_job" "job" {
  name        = "test-job"
  description = "test job"
  schedule    = "*/2 * * * *"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.topic.id
    data       = base64encode("test")
  }
}