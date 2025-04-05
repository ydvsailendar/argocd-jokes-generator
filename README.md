# README

## Installation

### install gcloud cli

```bash
brew install --cask google-cloud-sdk
```

## Login

### gcloud login

- normal login (used for cli)

```bash
gcloud auth login
```

- project setup (select default project)

```bash
gcloud init
```

- app login (terraform)

```bash
gcloud auth application-default login
```

## Terraform State

### Google Cloud Storage (GCS) Bucket

- enable gcs api

```bash
gcloud services enable storage.googleapis.com
```

- create storage bucket

```bash
gcloud storage buckets create gs://devsecops-tfs --location europe-west2 --uniform-bucket-level-access
```

- enable versioning

```bash
gcloud storage buckets update gs://devsecops-tfs --versioning
```

- verify gcs bucket configuration

```bash
gcloud storage buckets describe gs://devsecops-tfs
```

### Kubernetes (Container) Engine

- enable gke service

```bash
gcloud services enable container.googleapis.com
```

- If you cluster is regional make sure the region has enough space quota or you have setup disk size gb to within the quoto limit during cluster and node pool creation, if not it will fail with below errors, The region for the failure is your cluster is a regional cluster and you are using a default disk size which is 100GB which for my case is london region which has 3 zones makes it 300GB because regional cluster are replicated across zones in the region:

```text
Error: googleapi: Error 403: Insufficient regional quota to satisfy request: resource "SSD_TOTAL_GB": request requires '300.0' and is short '50.0'. project has a quota of '250.0' with '250.0' available.
```

- regional/zonal cluster --> if you don't want high availability which is case for non prod env you can go for zonal cluster, the region is if you have node count of 1 for a regional cluster it will create replication in each zone available in the region. i.e if there are 3 zones in a region it will create 3 nodes.

- If you provisioned the cluster and want to access the cluster using kubectl and gcloud you need to install the gke-gcloud-plugin this plugins helps fetch the credentials and setup to use with kubectl.

```bash
gcloud components install gke-gcloud-auth-plugin
```

```text
CRITICAL: ACTION REQUIRED: gke-gcloud-auth-plugin, which is needed for continued use of kubectl, was not found or is not executable. Install gke-gcloud-auth-plugin for use with kubectl by following https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin
```

- retrieve the access credentials for your cluster and automatically configure kubectl

```bash
gcloud container clusters get-credentials devsecops-cluster --region europe-west2-a
```

- install kubectl -> <https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/>

- install terraform -> <https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli>

- set context to new cluster of gke

```bash
kubectl config set-context gke_devsecops-452321_europe-west2-a_devsecops-cluster
```

- check current context

```bash
kubectl config current-context
``

- get nodes

```bash
kubectl get nodes
```

- get namespace

```bash
kubectl get ns
```

- set preferred namespace

```bash
kubectl config set-context --current --namespace argocd
```

- check current namespace and cluster

```bash
# under current context check namespace
kubectl config view --minify
```

## Argo CD

- install argocd cli

```bash
brew install argocd
``
- create resources for argocd
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- expose via service will give external ip

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

- get initial admin password

```bash
argocd admin initial-password -n argocd
```

- argocd login

```bash
argocd login 123.123.123.1
```

- update admin password

```bash
argocd account update-password
```

- add cluster (we are running in same cluster hence not needed)

```bash
argocd cluster add docker-desktop
```

- to login to the ui just copy paste the service load balancer ip

## Jokes App

- create project

```bash
kubectl apply -f joke-generator/project.yaml
```

- deploy app

```bash
kubectl apply -f joke-generator/application.yaml
```

```bash
argocd app sync joke-generator
```

- to access the api it only has one get request at /jokes get the external ip of the service (this service is already of load balancer type during creation) and port of 5000

```bash
curl http://35.246.91.71:5000/jokes
```

## Kubernetes Dashboard

- deploy dashboard

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

- deploy service account and cluster role binding

```bash
kubectl apply -f joke-generator/dashboard.yaml
```

- expose via service will give external ip

```bash
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec": {"type": "LoadBalancer"}}'
```

- to login generated token and visit the service external ip

```bash
kubectl -n kubernetes-dashboard create token admin-user
```

## AWS CLI

- install -> <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>

- setup -> <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html>
