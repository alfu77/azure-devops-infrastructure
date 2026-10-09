
# Azure Infrastructure, Docker & Kubernetes

## Overview

This project demonstrates the deployment and management of cloud infrastructure using Terraform, containerization with Docker, image management through Azure Container Registry (ACR), and application deployment using Kubernetes.

The project combines Infrastructure as Code (IaC) with container technologies to establish a structured, repeatable approach to infrastructure provisioning and application deployment on Microsoft Azure.

## Architecture

```text
          Terraform
              |
              v
       Microsoft Azure
              |
              v
     Azure Container Registry
              |
              v
        Docker Image
       (Nginx + Website)
              |
              v
          Kubernetes
        /           \
      Pod 1         Pod 2
        \           /
         Kubernetes
           Service
```

## Technologies

| Technology | Purpose |
|---|---|
| Microsoft Azure | Cloud infrastructure |
| Terraform | Infrastructure as Code |
| Docker | Application containerization |
| Nginx | Web server and static content delivery |
| Azure Container Registry | Container image storage |
| Kubernetes | Container orchestration |
| Git & GitHub | Version control and project management |
| YAML | Infrastructure and Kubernetes configuration |

## Project Components

### 1. Infrastructure as Code

Azure infrastructure is managed using Terraform, providing a consistent and maintainable approach to resource provisioning and configuration.

Key areas include resource management, provider configuration, and Terraform state management.

### 2. Containerization

The Nimbus website is packaged into a Docker image using `nginx:alpine` as its base image.

The image contains the website's HTML, CSS, JavaScript, static assets, and Nginx configuration.

### 3. Azure Container Registry

The Docker image is published to Azure Container Registry for centralized storage and retrieval.

**Image:** `nimbus-site:v1`

### 4. Kubernetes Deployment

Kubernetes manifests define the application's desired state, including:

- Two application replicas
- Rolling update strategy
- Readiness probe
- CPU and memory requests and limits
- A Kubernetes Service to expose the application

These configurations establish the foundation for reliable application deployment and controlled updates.

## Repository Structure

```text
AZURE-TERRAFORM-IAC/
├── terraform/
├── nimbus-site/
│   ├── assets/
│   ├── index.html
│   ├── styles.css
│   ├── app.js
│   ├── dockerfile
│   ├── nginx.conf
│   └── README.md
├── Kubernetes/
│   └── k8s/
│       ├── deployment.yaml
│       └── service.yaml
└── screenshot/
```

## Deployment Workflow

1. Provision and manage Azure infrastructure with Terraform.
2. Package the website into a Docker image using Nginx.
3. Publish the image to Azure Container Registry.
4. Define the application deployment and service using Kubernetes manifests.
5. Validate the deployment and application availability.

## Engineering Focus

This project demonstrates practical implementation of:

- Infrastructure as Code
- Cloud resource management
- Docker image creation and registry integration
- Kubernetes workload and service configuration
- Version control and infrastructure organization
- Resource allocation and application health checks

## Future Improvements

- Implement CI/CD pipelines for automated builds and deployments.
- Integrate monitoring and centralized logging.
- Strengthen secrets management and deployment security.
- Improve infrastructure validation and automated testing.

## Project Goal

To develop a practical DevOps workflow that connects cloud infrastructure provisioning, container image management, and Kubernetes application deployment using modern infrastructure and automation tools.
