resource "azurerm_storage_account" "sa" {
  name                            = "${var.project_name}sa77"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Standard"
  account_replication_type        = var.storage_replication_type
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"



}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"

}