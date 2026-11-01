# Création du cluster GKE Autopilot avec le module de Google

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster"
  version = "~> 46.0"

  project_id          = var.project_id          # projet du lab
  name                = var.cluster_name        # nom du cluster
  region              = var.region              # autopilot = cluster régional
  network             = var.network             # réseau default du lab
  subnetwork          = var.subnetwork          # sous-réseau default
  ip_range_pods       = var.ip_range_pods       # null -> GKE choisit
  ip_range_services   = var.ip_range_services   # null -> GKE choisit
  release_channel     = var.release_channel     # canal de maj
  deletion_protection = var.deletion_protection # false pour pouvoir faire destroy
}
