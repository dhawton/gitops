variable "do_token" {
  description = "DigitalOcean API token"
  type       = string
}

variable "kubernetes_minor_version" {
  description = "Kubernetes minor version"
  type        = string
  default     = "1.29"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "cluster_region" {
  description = "Region of the Kubernetes cluster"
  type        = string
}

variable "cluster_nodepool_name" {
  description = "Name of the Kubernetes node pool"
  type        = string
  default     = "default"
}

variable "cluster_nodepool_type" {
  description = "Type of the Kubernetes node pool"
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "cluster_nodepool_min_nodes" {
  description = "Minimum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 1
}

variable "cluster_nodepool_max_nodes" {
  description = "Maximum number of nodes in the Kubernetes node pool"
  type        = number
  default     = 3
}
