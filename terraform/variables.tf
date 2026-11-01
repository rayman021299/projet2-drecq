# Variables du projet (les valeurs sont dans terraform.tfvars)

variable "project_id" {
  description = "ID du projet GCP fourni par le lab."
  type        = string
}

variable "region" {
  description = "Région fournie par le lab (ex : us-central1)."
  type        = string
}

variable "cluster_name" {
  description = "Nom du cluster GKE."
  type        = string
  default     = "autopilot-cluster-1"
}

variable "network" {
  description = "Réseau VPC utilisé."
  type        = string
  default     = "default"
}

variable "subnetwork" {
  description = "Sous-réseau utilisé."
  type        = string
  default     = "default"
}

variable "ip_range_pods" {
  description = "Plage IP des pods (null = gérée par GKE)."
  type        = string
  default     = null
}

variable "ip_range_services" {
  description = "Plage IP des services (null = gérée par GKE)."
  type        = string
  default     = null
}

variable "release_channel" {
  description = "Canal de mise à jour de GKE."
  type        = string
  default     = "REGULAR"
}

variable "deletion_protection" {
  description = "Protection contre la suppression du cluster."
  type        = bool
  default     = false
}
