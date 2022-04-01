provider "aviatrix" {}

provider "aws" {
  region = var.aws_region
}

provider "aws" {
  region = var.aws_s2c_region
  alias  = "s2c"
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "time" {}

provider "http" {}