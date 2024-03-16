resource "google_service_account" "adhp_service_account" {
  account_id = "external-secrets-k8s"
  display_name = "external-secrets-k8s"
  project = "adhp-386716"
}

resource "google_service_account" "addysnip_service_account" {
  account_id = "tor1-secret-manager"
  display_name = "tor1-secret-manager"
  project = "addysnip"
}

import {
  id = "projects/addysnip/serviceAccounts/tor1-secret-manager@addysnip.iam.gserviceaccount.com"
  to = google_service_account.addysnip_service_account
}

import {
  id = "projects/adhp-386716/serviceAccounts/external-secrets-k8s@adhp-386716.iam.gserviceaccount.com"
  to = google_service_account.adhp_service_account
}

resource "google_service_account_key" "adhp-service-account-key" {
  service_account_id = google_service_account.adhp_service_account.id 
}

resource "google_service_account_key" "addysnip-service-account-key" {
  service_account_id = google_service_account.addysnip_service_account.id 
}

resource "kubernetes_secret_v1" "addysnip-gcpsm-secret" {
  metadata {
    name = "addysnip-gcpsm-secret"
    namespace = kubernetes_namespace.external_secrets.metadata[0].name
  }

  data = {
    secret-access-credentials = google_service_account_key.addysnip-service-account-key.private_key
  }
}

resource "kubernetes_secret_v1" "adhp-gcpsm-secret" {
  metadata {
    name = "adhp-gcpsm-secret"
    namespace = kubernetes_namespace.external_secrets.metadata[0].name
  }

  data = {
    secret-access-credentials = google_service_account_key.adhp-service-account-key.private_key
  }
}
