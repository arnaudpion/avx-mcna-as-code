terraform {
  required_providers {
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "2.22.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2"
    }
    google = {
      source  = "hashicorp/google"
      version = "~>4"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.7.2"
    }
    http = {
      source  = "hashicorp/http"
      version = "~>2.1.0"
    }
  }
  required_version = ">= 0.13"
}