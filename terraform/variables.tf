variable "project_name" {
  description = "Base name for all resources"
  type        = string
  default     = "ghost"
}

variable "github_actions_principal_object_id" {
  description = "Object ID of the service principal used by the GitHub Actions workflow"
  type        = string
  default     = "8dc5278a-9016-4d62-91cd-119c948ded40"

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.github_actions_principal_object_id))
    error_message = "Provide the website deployment service principal object ID as a GUID."
  }
}

variable "terraform_principal_object_id" {
  description = "Object ID of the service principal used by the Terraform workflow"
  type        = string
  default     = "ed81dc60-b8a8-4408-a0e0-07444cbc856b"

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.terraform_principal_object_id))
    error_message = "Provide the Terraform service principal object ID as a GUID."
  }
}

variable "location" {
  description = "Azure region to deploy resources (e.g., UK South)"
  type        = string
  default     = "East US 2"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "Ghost"
  }
}

# ACR
variable "acr_sku" {
  description = "SKU for Azure Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

# AKS
variable "aks_node_count" {
  description = "Number of nodes in the default AKS node pool"
  type        = number
  default     = 1
}


variable "aks_vm_size" {
  type    = string
  default = "Standard_D4s_v7"
}
# Key Vault
variable "kv_sku" {
  description = "SKU for Azure Key Vault (standard or premium)"
  type        = string
  default     = "standard"
}

# Storage
variable "storage_replication_type" {
  description = "Replication type for the storage account (LRS, GRS, RAGRS)"
  type        = string
  default     = "LRS"
}
