terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
        }
        kubernetes = {
            source = "hashicorp/kubernetes"
        }
        google = {
            source = "hashicorp/google"
        }
    }
    backend "s3" {
        endpoint                    = "sfo3.digitaloceanspaces.com"
        key                         = "tor2/terraform.tfstate"
        bucket                      = "daniel-k8s"
        region                      = "us-west-1"
        skip_credentials_validation = true
        skip_metadata_api_check     = true
    }
}

provider "digitalocean" {
    token = var.do_token
}

provider "kubernetes" {
    host             = digitalocean_kubernetes_cluster.cluster.endpoint
    token            = digitalocean_kubernetes_cluster.cluster.kube_config[0].token
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
}

provider "google" {
    project = "adhp-386716"
    region  = "us-central1"
}