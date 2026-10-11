# Resource Group

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name

}

output "resource_group_location" {
  description = "The azure region of the resource group"
  value       = azurerm_resource_group.rg.location

}

output "acr_name" {
  description = "the name of the Azure Container registry"
  value       = azurerm_container_registry.acr.name

}

output "acr_login_server" {
  description = "The login server URL for the ACR"
  value       = azurerm_container_registry.acr.login_server

}

output "aks_name" {

  description = "this is the name of the Azure Cluster"
  value       = azurerm_kubernetes_cluster.aks.name

}


output "KV_name" {

  description = "This is our keyvault Name"
  value       = azurerm_key_vault.kv.name

}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.sa.name

}

output "storage_container_name" {
  description = "the name of the storage container for terraform state"
  value       = azurerm_storage_container.container.name
}