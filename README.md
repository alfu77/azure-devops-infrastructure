# Azure DevOps Infrastructure & CI/CD

An end-to-end Azure DevOps project demonstrating Infrastructure as Code (IaC), containerization, automated application delivery, Kubernetes orchestration, and observability using Microsoft Azure, Terraform, Docker, GitHub Actions, Prometheus, and Grafana.

## Project Overview

This project brings together the core stages of a modern DevOps workflow, from provisioning cloud infrastructure to deploying and monitoring a containerized portfolio website.

Terraform manages the Azure infrastructure, while GitHub Actions automates infrastructure changes and application delivery. Docker packages the website into a container image, Azure Container Registry (ACR) stores the image, and Azure Kubernetes Service (AKS) orchestrates the application. Prometheus and Grafana provide visibility into cluster and workload health.

The project was designed around repeatable deployments, separation of responsibilities, cloud resource efficiency, and practical troubleshooting of real infrastructure and CI/CD issues.

## Architecture

The solution follows two connected workflows: infrastructure provisioning and application delivery. Monitoring provides operational visibility into the deployed workloads.

### End-to-End Workflow

```text
                    SOURCE CONTROL
                     Git / GitHub
                          |
              +-----------+-----------+
              |                       |
        Terraform Changes       Website Changes
              |                       |
       GitHub Actions           GitHub Actions
              |                       |
       Terraform Workflow      Build/Deploy Workflow
              |                       |
       Azure Infrastructure     Docker Container Image
              |                       |
       Azure Resources          Azure Container Registry
              |                       |
       Remote TF State                  |
              |                       |
              |                 Azure Kubernetes
              |                    Service
              |                       |
              |                 Kubernetes Deployment
              |                       |
              |                 Kubernetes Service
              |                       |
              |                 Portfolio Website
              |                       |
              +-----------------------+
                          |
                 Monitoring Stack
                          |
                 Prometheus + Grafana
```

*Note: This diagram represents the logical workflow. Terraform provisioning and application deployment are separate automation processes.*

## Technology Stack

| Category | Technologies |
|---|---|
| Cloud platform | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Containerization | Docker |
| Container registry | Azure Container Registry (ACR) |
| Container orchestration | Azure Kubernetes Service (AKS) |
| CI/CD automation | GitHub Actions |
| Version control | Git and GitHub |
| Monitoring | Prometheus and Grafana |
| Package management | Helm |
| Kubernetes administration | kubectl |
| Cloud administration | Azure CLI |
| Application | HTML, CSS, JavaScript |

## 1. Infrastructure Provisioning with Terraform

Terraform provides a repeatable way to define and manage the Azure infrastructure required by the project.

Instead of manually creating every resource in the Azure Portal, infrastructure is described as code and managed through Terraform configuration files.

### Infrastructure responsibilities

The infrastructure layer supports the resources used by the application delivery workflow, including:

- Azure resource group and supporting cloud resources.
- Azure Container Registry for storing container images.
- Azure Kubernetes Service for running containerized workloads.
- Supporting Azure services and configuration defined in the Terraform project.

The exact resources created depend on the current Terraform configuration.

### Terraform workflow

The infrastructure workflow follows this process:

1. Define the required Azure resources in Terraform.
2. Format and validate the configuration.
3. Initialize Terraform and its provider.
4. Generate and review an execution plan.
5. Apply the configuration to provision or update infrastructure.
6. Store Terraform state remotely so the infrastructure can be managed consistently across runs.

### Remote Terraform state

The project uses an Azure Storage backend to store Terraform state separately from the application infrastructure.

The configured backend uses:

- Resource group: `ghost-rg`
- Storage account: `ghostsa77`
- Blob container: `tfstate`
- State key: `terraform.tfstate`

Remote state helps maintain a consistent record of Terraform-managed resources across local and automated runs. The storage account and state container must exist before Terraform initializes the backend.

The state backend is intentionally separate from the infrastructure managed by Terraform. When cleaning up practice infrastructure, the state storage must be preserved.

## 2. Infrastructure Automation with GitHub Actions

A dedicated Terraform workflow automates infrastructure operations when relevant Terraform files or the workflow itself change on the `main` branch.

The workflow is maintained separately from the application deployment pipeline.

### Automated infrastructure process

The workflow is designed to:

1. Check out the repository.
2. Authenticate to Azure.
3. Set up Terraform.
4. Format and validate the Terraform configuration.
5. Initialize the remote backend.
6. Generate an infrastructure plan.
7. Apply the approved configuration according to the workflow's configured automation policy.

This approach reduces repetitive manual operations and makes infrastructure changes traceable through Git history and workflow logs.

### Azure authentication

GitHub Actions authenticates to Azure using the configured credentials and authentication method. The project has used the `AZURE_TERRAFORM_CREDENTIALS` GitHub Actions secret and an OpenID Connect (OIDC)-based approach for Azure authentication.

Credentials should be stored in GitHub Actions secrets or configured through a properly secured OIDC trust relationship. Sensitive values must never be committed to the repository.

## 3. Application Containerization with Docker

The portfolio website is a static web application built with HTML, CSS, and JavaScript.

Docker packages the website and its required web server into a portable container image.

The container image provides a consistent runtime environment, allowing the website to run locally and in Kubernetes without manually configuring a web server on every deployment target.

### Containerization process

1. Maintain the website source code and Dockerfile in GitHub.
2. Build the container image.
3. Test the image locally where appropriate.
4. Tag the image for publishing.
5. Push the image to Azure Container Registry.

The image tag identifies a particular image version. Using versioned or commit-specific tags makes it easier to identify which application build is deployed.

## 4. Azure Container Registry

Azure Container Registry acts as the private image repository for the project's containerized applications.

The registry used in this project is:

`ghostacr77.azurecr.io`

The image delivery process is:

```text
Website Source Code
        |
        v
    Docker Build
        |
        v
   Container Image
        |
        v
Azure Container Registry
        |
        v
Azure Kubernetes Service
```

ACR separates image storage from application execution. Once an image has been published, AKS can retrieve it to create or update application containers, provided registry authentication and permissions are configured correctly.

Keeping the image registry separate from the cluster also allows an image to be reused during subsequent deployments.

## 5. Application Deployment with Azure Kubernetes Service

Azure Kubernetes Service provides the managed Kubernetes environment in which the portfolio application runs.

The project uses Kubernetes resources to manage application instances and expose the website.

### Kubernetes components

**Deployment**

A Kubernetes Deployment defines the desired application state, including the container image and the required number of replicas. It also supports rolling updates and replacement of failed Pods.

**Pods**

Pods run the application's container workloads. Kubernetes schedules and manages them according to the desired Deployment state.

**Service**

A Kubernetes Service provides a stable network endpoint for accessing the application. The exposure method depends on the Service configuration; a LoadBalancer Service can provision an external Azure load balancer.

### Deployment process

1. Authenticate to Azure.
2. Retrieve the required AKS cluster credentials.
3. Configure the Kubernetes context.
4. Apply or update the application Deployment.
5. Configure the Service to expose the website as required.
6. Wait for the rollout to complete.
7. Verify Pod status and application accessibility.

### Application updates

When the website changes, a new container image is built and published to ACR. The Kubernetes Deployment is then updated to use the new image.

For example, an image may move from `v1` to `v2`, or the deployment may use a unique Git commit tag. The exact tag must match an image available in the registry.

A successful image push does not, by itself, update the running application. The deployment workflow must also update the Kubernetes workload and confirm that the rollout succeeds.

## 6. CI/CD with GitHub Actions

The project separates infrastructure automation from application delivery so that each workflow has a clear responsibility.

### Infrastructure pipeline

Responsible for Terraform configuration changes and infrastructure lifecycle operations.

```text
Git Push
   |
   v
Terraform Workflow
   |
   v
Format and Validate
   |
   v
Initialize Backend
   |
   v
Plan and Apply
   |
   v
Azure Infrastructure
```

### Application pipeline

Responsible for delivering changes to the website.

```text
Website Code Change
        |
        v
   GitHub Actions
        |
        v
   Build Docker Image
        |
        v
   Push Image to ACR
        |
        v
   Update AKS Deployment
        |
        v
   Verify Rollout
        |
        v
   Updated Website
```

The workflows are independent. A website-only change should trigger the application delivery workflow rather than unnecessarily provisioning infrastructure again. Infrastructure changes should trigger the Terraform workflow according to its configured path filters.

### Benefits

- Repeatable infrastructure and application deployments.
- Version-controlled infrastructure and application code.
- Reduced manual deployment steps.
- Traceability through Git commits and GitHub Actions logs.
- Clear separation between infrastructure changes and application releases.
- Easier diagnosis of failed builds, authentication issues, image pulls, and Kubernetes rollouts.

## 7. Monitoring and Observability with Prometheus and Grafana

After deploying the application to AKS, the project adds a monitoring layer using Prometheus and Grafana.

The objective is to move beyond confirming that the website is deployed and gain visibility into the health and resource usage of the Kubernetes environment.

### Prometheus

Prometheus collects and stores time-series metrics from configured monitoring targets.

In this project, the monitoring stack is deployed using the community-maintained `kube-prometheus-stack` Helm chart. This stack brings together Prometheus and supporting monitoring components, with exporters and integrations used to collect Kubernetes and node metrics.

Prometheus can help investigate questions such as:

- How much CPU and memory are workloads using?
- Are Pods healthy and available?
- Are resource usage levels increasing over time?
- Are monitored targets reporting metrics successfully?

Metric availability depends on the configured exporters, scrape targets, permissions, and Prometheus configuration.

### Grafana

Grafana provides dashboards and visualizations for querying and interpreting metrics.

Grafana can use Prometheus as a data source to present metrics through charts, panels, and dashboards.

It helps operators interpret the information collected by Prometheus rather than requiring them to inspect raw metric queries continuously.

### Prometheus vs. Grafana

| Prometheus | Grafana |
|---|---|
| Collects and stores metrics | Visualizes and presents metrics |
| Scrapes configured monitoring targets | Queries configured data sources |
| Provides a metrics query language called PromQL | Provides dashboards and panels |
| Evaluates configured alerting rules | Can display alert information and support alerting integrations |

**In simple terms:** Prometheus gathers the measurements; Grafana makes those measurements easier to understand.

### Monitoring installation

The monitoring setup uses a shell script named `setup-monitoring.sh` and Helm.

The script adds or updates the Prometheus community Helm repository and installs the monitoring stack in a dedicated Kubernetes namespace named `monitoring`.

The Helm release used in the project is `kps`.

The installation creates the monitoring components defined by the selected chart configuration, including Prometheus, Grafana, and Alertmanager.

The actual resources and component names depend on the chart version and values used during installation.

### Monitoring workflow

```text
Azure Kubernetes Service
          |
          v
 Kubernetes Workloads
          |
          v
Configured Metrics Targets
          |
          v
     Prometheus
          |
          v
       PromQL
          |
          v
       Grafana
          |
          v
 Dashboards and Visualization
```

Alertmanager, included in the monitoring stack, can handle alerts generated by configured alerting rules and route them to configured receivers. Notifications require appropriate rules and receiver configuration.

### What the monitoring layer adds

- Visibility into Kubernetes and workload metrics.
- A dedicated monitoring namespace.
- Centralized dashboards for interpreting metrics.
- A foundation for investigating resource consumption and workload health.
- A starting point for configuring alert rules and notification channels.

Monitoring complements CI/CD: the pipeline verifies whether a deployment has completed, while monitoring helps assess the behavior and health of the environment after deployment.

## 8. Git and Version Control

Git and GitHub provide version control for infrastructure definitions, application source code, Docker configuration, Kubernetes manifests, workflow definitions, and documentation.

The project uses version-controlled changes to make deployments traceable and simplify troubleshooting.

A disciplined workflow includes:

- Committing focused changes.
- Using descriptive commit messages.
- Reviewing changes before merging into `main`.
- Keeping infrastructure and application changes distinguishable.
- Documenting important operational decisions and troubleshooting outcomes.

## 9. Validation and Troubleshooting

The project involved troubleshooting issues across infrastructure provisioning, authentication, image publishing, Kubernetes deployment, and monitoring.

Examples of useful validation checks include:

| Area | Validation |
|---|---|
| Terraform | Formatting, validation, initialization, plan output |
| Azure | Resource status and authentication |
| ACR | Image repository and tag availability |
| Kubernetes | Pod status, Deployment status, Service configuration |
| CI/CD | GitHub Actions logs and workflow exit status |
| Monitoring | Prometheus targets, metrics availability, Grafana data source and dashboards |

Common failure categories include:

- Incorrect Azure authentication or permissions.
- Remote state backend configuration errors.
- Container image names or tags that do not exist.
- Registry authentication and image-pull failures.
- Kubernetes rollout failures or unhealthy Pods.
- Monitoring targets that are unavailable or not being scraped.
- Grafana data source or dashboard configuration problems.

For the actual incidents encountered, their causes, resolutions, resource naming changes, IP migration, and useful operational commands, see the [Operations and Troubleshooting Guide](https://github.com/alfu77/azure-devops-infrastructure/blob/main/docs/operations-and-troubleshooting.md).

## 10. Cost Management and Resource Lifecycle

Cloud resources can continue generating charges when they are no longer being used. Cost management is therefore an important part of this project.

The infrastructure lifecycle should support creating resources for practice and removing project-managed resources when they are no longer required.

Cost-conscious operating practices include:

- Deploying AKS only when it is needed for a lab or demonstration.
- Using appropriate VM sizes and avoiding unnecessary replicas or supporting resources.
- Reviewing Azure pricing before provisioning services.
- Checking for public IP addresses, load balancers, disks, and other billable resources after testing.
- Destroying practice infrastructure when finished.
- Preserving the remote Terraform state backend if infrastructure is intended to be rebuilt later.
- Verifying the final resource inventory in Azure after cleanup.

**Important:** Terraform destruction should be limited to resources managed by the intended Terraform configuration. The remote state storage account and container must be preserved if they are required for future Terraform operations. Deleting an AKS cluster or other infrastructure does not automatically guarantee that every related billable resource has been removed.

## 11. Repository Structure

The repository contains the infrastructure and application delivery configuration for the project. The following is a conceptual view; exact paths and filenames should match the current repository.

```text
azure-devops-infrastructure/
├── .github/
│   └── workflows/
│       ├── terraform.yaml
│       └── application-deployment-workflow
├── terraform/
│   └── Terraform configuration files
├── docs/
│   └── operations-and-troubleshooting.md
├── setup-monitoring.sh
├── Dockerfile
└── README.md
```

The Terraform configuration defines Azure infrastructure. GitHub Actions workflows automate infrastructure and application operations. The Dockerfile packages the website, the monitoring script installs the monitoring stack, and the documentation records operational knowledge.

*Adjust this tree to reflect the exact tracked files in the repository, especially the application source directory and actual application workflow filename.*

## 12. Project Outcomes

This project demonstrates practical experience with:

- Infrastructure as Code using Terraform.
- Azure resource provisioning and lifecycle management.
- Remote Terraform state using Azure Storage.
- Secure cloud authentication for automation.
- Docker image creation and container registry management.
- Kubernetes Deployments, Pods, Services, and rolling updates.
- GitHub Actions CI/CD pipeline design.
- Separation of infrastructure and application workflows.
- Kubernetes monitoring with Prometheus and Grafana.
- Helm-based installation of a monitoring stack.
- Troubleshooting cloud authentication, image pulls, deployments, and monitoring.
- Cost-aware operation of cloud-based lab environments.

## Conclusion

The project demonstrates an end-to-end DevOps workflow connecting infrastructure provisioning, container image management, automated deployment, Kubernetes orchestration, and observability on Microsoft Azure.

By combining Terraform, Docker, ACR, AKS, GitHub Actions, Prometheus, and Grafana, the solution establishes a practical foundation for repeatable deployments and operational visibility.

The emphasis is not only on getting an application running, but also on managing the infrastructure behind it, automating its delivery, investigating failures, observing workload health, and controlling cloud resource costs.

## Project Repository

[View the Azure DevOps Infrastructure Repository](https://github.com/alfu77/azure-devops-infrastructure)

   
