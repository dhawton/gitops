# ArgoCD

This directory is used both for initial installation as well as for its ongoing management.

## Installation

To install ArgoCD, run the following command:

```bash
helm dependency update
helm install argocd . -n argocd --create-namespace
```

## Upgrades

To upgrade ArgoCD, you'll need to bump the version in Chart.yaml.

Keep in mind that Helm will not upgrade the CRDs, so you'll need to run the following command:

```bash
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
```

You can replace `stable` above with a specific version.

## Bootstrapping

After installing ArgoCD, there's a few other bits and bobs needed to bootstrap the cluster. The assumption is that these commands will be run from the project root.

1. Install the projects, this is a private yaml for now.

```bash
kubectl apply -f private/projects.yaml
```

2. Install the ArgoCD application so it can manage itself.

```bash
kubectl apply -f apps/argocd/application.yaml
```

3. Install the bootstrap app-of-apps

```bash
kubectl apply -f apps/bootstrap/application.yaml
```
