# Kong Flux Gitops

## Introduction

Reference setup of deploying Kong using Flux v2

![Flux-Diagram](assets/kong-flux.png?raw=true)


## Set-up

For this reference implementation, we will use Github to store our artifacts , and EKS for the deployments. You can imeplement this using any CI/CD toolings or any Kubernetes clusters.

```
# Creating a Sample Cluster in AWS
eksctl create cluster --name Kong-UC-Test-Cluster  --version 1.22 --region ap-southeast-2  --without-nodegroup

eksctl create nodegroup --cluster Kong-UC-Test-Cluster --name Worker-NG  --region ap-southeast-2  --node-type m5.large --nodes 1 --max-pods-per-node 50
```

### Bootstraping Flux 

The bootstrap github command creates a GitHub repository if one doesn’t exist and commits the Flux components manifests to specified branch. Then it configures the target cluster to synchronize with that repository by setting up an SSH deploy key or by using token-based authentication

```
# Set Personal Access Token
export GITHUB_TOKEN=<your-token>

flux bootstrap github \
  --owner=my-github-username \
  --repository=my-repository \
  --path=clusters/my-cluster \
  --branch=master \
  --personal
```

If required, you can remove Flux from the cluster by running the following command 

```
 flux uninstall --namespace=flux-system
```



