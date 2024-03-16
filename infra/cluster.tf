data "digitalocean_kubernetes_versions" "current" {
    version_prefix = var.kubernetes_minor_version
}

resource "digitalocean_kubernetes_cluster" "cluster" {
    name   = var.cluster_name
    region  = var.cluster_region
    version = data.digitalocean_kubernetes_versions.current.latest_version
    node_pool {
        name       = var.cluster_nodepool_name
        size       = var.cluster_nodepool_type
        auto_scale = true
        min_nodes = var.cluster_nodepool_min_nodes
        max_nodes = var.cluster_nodepool_max_nodes
    }
}
