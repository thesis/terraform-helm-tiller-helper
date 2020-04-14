output "tiller_namespace" {
  description = "The tiller namespace name."
  value       = "${var.tiller_namespace_name}"
}

output "tiller_service_account" {
  description = "The tiller service account name."
  value       = "${kubernetes_service_account.tiller.metadata.0.name}"
}
