terraform {
    required_providers {
        digitalocean = {
            source = "digitalocean/digitalocean"
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

variable "do_token" {}

provider "digitalocean" {
    token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "tor2" {
    name   = "tor2"
    region  = "tor1"
    version = "1.29.1-do.0"
    node_pool {
        name       = "default"
        size       = "s-2vcpu-4gb"
        auto_scale = true
        min_nodes = 1
        max_nodes = 5
    }
}
