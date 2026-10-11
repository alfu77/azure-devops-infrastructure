# Azure DevOps Infrastructure & CI/CD

## Project Overview

This project demonstrates an end-to-end application delivery workflow using Microsoft Azure, Docker, Kubernetes, and GitHub Actions.

The solution covers containerizing a static portfolio website, publishing Docker images to Azure Container Registry (ACR), and deploying the application to Azure Kubernetes Service (AKS). The architecture supports independent application deployments within an existing Kubernetes cluster, promoting resource efficiency and workload separation.

The project also incorporates Git-based collaboration and CI/CD automation to streamline application updates and deployment operations.

## Technology Stack

- **Azure:** Azure Container Registry (ACR), Azure Kubernetes Service (AKS)
- **Containers:** Docker
- **Orchestration:** Kubernetes Deployments and Services
- **CI/CD:** GitHub Actions
- **Version Control:** Git and GitHub
- **Frontend:** HTML, CSS, JavaScript
- **Administration:** Azure CLI and kubectl

## Key Achievements

- Developed and containerized a static portfolio website using Docker.
- Published container images to Azure Container Registry for centralized image management.
- Deployed containerized applications to AKS using Kubernetes manifests.
- Configured Kubernetes Deployments and Services to manage application instances and traffic exposure.
- Structured the deployment approach to run separate applications within an existing AKS cluster.
- Applied Git branching, commits, and pull-request workflows to manage infrastructure and application changes.
- Integrated Azure authentication and Kubernetes deployment steps into a GitHub Actions CI/CD workflow.

## Engineering Focus

The project emphasizes repeatable deployments, container image management, workload isolation, cloud resource efficiency, and automation of application delivery.

The objective is to establish a maintainable CI/CD process that connects source control, container builds, image publishing, and Kubernetes deployments on Azure.

## Operations and Troubleshooting

See [the operations and troubleshooting record](docs/operations-and-troubleshooting.md) for the Azure and CI/CD errors encountered, their causes and resolutions, Terraform changes, deployment naming/IP migration, and commonly used commands.

