# Resource Group

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name

}

output "resource_group_location" {
  description = "The Azure region containing the resource group"
  value       = azurerm_resource_group.rg.location

}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name

}

output "acr_login_server" {
  description = "The ACR login server used to tag and push container images"
  value       = azurerm_container_registry.acr.login_server

}

output "aks_name" {

  description = "The name of the Azure Kubernetes Service cluster"
  value       = azurerm_kubernetes_cluster.aks.name

}


output "KV_name" {

  description = "The name of the Azure Key Vault"
  value       = azurerm_key_vault.kv.name

}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.sa.name

}

output "storage_container_name" {
  description = "The name of the private container used for Terraform state"
  value       = azurerm_storage_container.container.name
}

output "resource_group_id" {
  description = "The Azure resource ID of the resource group"
  value       = azurerm_resource_group.rg.id
}

output "acr_id" {
  description = "The Azure resource ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "aks_id" {
  description = "The Azure resource ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_api_server_fqdn" {
  description = "The fully qualified domain name of the AKS Kubernetes API server"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "key_vault_uri" {
  description = "The URI used to access the Azure Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}

output "storage_account_id" {
  description = "The Azure resource ID of the storage account"
  value       = azurerm_storage_account.sa.id
}

output "storage_container_id" {
  description = "The Azure resource ID of the Terraform state container"
  value       = azurerm_storage_container.container.id
}