# Terraform - cluster GKE

Crée le cluster GKE Autopilot `autopilot-cluster-1` dans le projet du lab. Terraform ne déploie rien dans le cluster, c'est Helm qui s'en occupe.

## Ressources

Module utilisé : `terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-public-cluster`, version `~> 46.0`.

Ce qu'il crée (vu avec `terraform state list`) :
- le cluster GKE Autopilot
- un compte de service pour les nœuds et 3 rôles IAM pour ce compte
- 2 ressources random (suffixe du nom du compte de service, choix des zones)

## Variables

| Nom | Description | Type | Défaut | Obligatoire |
|---|---|---|---|---|
| project_id | ID du projet du lab | string | - | oui |
| region | Région du lab | string | - | oui |
| cluster_name | Nom du cluster | string | autopilot-cluster-1 | non |
| network | Réseau VPC | string | default | non |
| subnetwork | Sous-réseau | string | default | non |
| ip_range_pods | Plage IP des pods | string | null | non |
| ip_range_services | Plage IP des services | string | null | non |
| release_channel | Canal de mise à jour GKE | string | REGULAR | non |
| deletion_protection | Empêche le destroy si true | bool | false | non |

## Providers

| Provider | Source | Contrainte | Version installée |
|---|---|---|---|
| google | hashicorp/google | ~> 7.28 | 7.46.2 |
| google-beta | hashicorp/google-beta | ~> 7.28 | 7.46.2 |
| kubernetes | hashicorp/kubernetes | ~> 2.10 | 2.38.0 |
| random | hashicorp/random | ~> 3.0 | 3.9.1 |

Ce sont les providers demandés par le module. Le fichier `.terraform.lock.hcl` est commité pour que tout le monde ait exactement les mêmes versions.

## Outputs

| Nom | Description | Exemple |
|---|---|---|
| cluster_name | Nom du cluster | autopilot-cluster-1 |
| cluster_location | Région du cluster | us-central1 |
| project_id | Projet du cluster | qwiklabs-gcp-01-xxxx |
| endpoint | Adresse de l'API (sensible) | (sensitive value) |
| kubernetes_version | Version de Kubernetes | 1.36.4-gke.2046003 |
| release_channel | Canal de mise à jour | REGULAR |
| connect_command | Commande de connexion | gcloud container clusters get-credentials ... |

L'endpoint se lit avec `terraform output -raw endpoint`.

## Commandes

Copier `terraform.tfvars.example` en `terraform.tfvars` et mettre le project_id et la région du lab. Si la région n'est pas affichée dans le lab, elle est dans `google-compute-default-region` avec :

```bash
gcloud compute project-info describe --format="value(commonInstanceMetadata.items)"
```

Se connecter avec le compte student du lab (la 1ère commande pour gcloud, la 2ème pour terraform) puis lancer terraform :

```bash
gcloud auth login
gcloud auth application-default login
terraform init
terraform plan
terraform apply
terraform output
terraform destroy
```

Le apply prend environ 5 min. Faire le destroy avant la fin du lab.

## Connexion au cluster

```bash
gcloud components install gke-gcloud-auth-plugin
gke-gcloud-auth-plugin --version
gcloud container clusters get-credentials autopilot-cluster-1 --location <REGION> --project <PROJECT_ID>
kubectl config current-context
kubectl cluster-info
```

La commande `get-credentials` est aussi donnée par `terraform output connect_command`.

Passer de minikube à GKE (et inversement) :

```bash
kubectl config get-contexts
kubectl config use-context minikube
kubectl config use-context gke_<PROJECT_ID>_<REGION>_autopilot-cluster-1
```

Toujours vérifier avec `kubectl config current-context` avant un `helm install` ou `helm upgrade`.

## State

Le state est en local car le projet du lab est supprimé à la fin de la session. Risques : le state n'est que sur un PC, pas de partage ni de verrou dans l'équipe. En entreprise on le mettrait dans un bucket GCS (backend `gcs`) avec verrouillage.
