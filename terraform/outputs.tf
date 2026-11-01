# Infos affichées après le apply

output "cluster_name" {
  description = "Nom du cluster."
  value       = module.gke.name
}

output "cluster_location" {
  description = "Région du cluster."
  value       = module.gke.location
}

output "project_id" {
  description = "Projet du cluster."
  value       = var.project_id
}

output "endpoint" {
  description = "Adresse de l'API Kubernetes."
  value       = module.gke.endpoint
  sensitive   = true
}

output "kubernetes_version" {
  description = "Version de Kubernetes."
  value       = module.gke.master_version
}

output "release_channel" {
  description = "Canal de mise à jour."
  value       = module.gke.release_channel
}

output "connect_command" {
  description = "Commande pour se connecter au cluster."
  value       = "gcloud container clusters get-credentials ${module.gke.name} --location ${module.gke.location} --project ${var.project_id}"
}
