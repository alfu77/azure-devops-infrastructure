terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.6.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "a3ca665f-a943-4a1c-bb07-d00847f550c5"

  features {}
}