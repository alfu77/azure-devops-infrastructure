
terraform {
  backend "azurerm" {
    resource_group_name  = "ghost-rg"
    storage_account_name = "ghostsa77"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    use_oidc         = true
    use_azuread_auth = true
  }
}
