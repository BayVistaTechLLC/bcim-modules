output "job_name" {
  description = "Cloud Scheduler job name"
  value       = google_cloud_scheduler_job.job.name
}

output "job_id" {
  description = "Cloud Scheduler job ID"
  value       = google_cloud_scheduler_job.job.id
}
