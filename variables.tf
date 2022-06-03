variable "deploy_aws" {
  description = "Deploy AWS as part of the Multi-Cloud Transit"
  type        = bool
  default     = true
}

variable "aws_prefix" {
  description = "Prefix used for resources in AWS"
  type        = string
  default     = "aws"
}

variable "aws_region" {
  description = "AWS region where we will deploy VPCs, Aviatrix Gateways, and EC2 instances"
  type        = string
  default     = "us-east-1"
}

variable "aws_region_short" {
  description = "Short format to indicate AWS region in VPCs and Gateways names"
  type        = string
  default     = "use1"
}

variable "aws_account_name" {
  description = "Name of your AWS account in the Aviatrix Controller"
  type        = string
}

variable "aws_transit_cidr" {
  description = "CIDR used for the Transit VPC in AWS"
  type        = string
  default     = "10.1.0.0/23"
}

variable "aws_spoke_cidr_list" {
  description = "CIDR blocks for the Spoke VPCs in AWS"
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "aws_s2c_region" {
  description = "Region for the S2C VPCs in AWS"
  type        = string
  default     = "us-west-2"
}

variable "aws_s2c_cidr" {
  description = "CIDR block for the S2C VPCs in AWS"
  type        = string
  default     = "172.16.0.0/23"
}

variable "aws_test_ec2_hostnum" {
  description = "Defines the host number / IP address of the test EC2 instance in a Spoke VPC in AWS"
  type        = number
  default     = 5
}

variable "aws_transit_gateway_size" {
  description = "Instance size used for Aviatrix Transit Gateways on AWS"
  type        = string
  default     = "t3.medium"
}

variable "aws_firenet_gateway_size" {
  description = "Instance size used for Aviatrix Transit Gateways on AWS"
  type        = string
  default     = "c5.xlarge"
}

variable "aws_firewall_size" {
  description = "Instance size used for Aviatrix Spoke Gateways on AWS"
  type        = string
  default     = "c5.xlarge"
}

variable "aws_spoke_gateway_size" {
  description = "Instance size used for Aviatrix Spoke Gateways on AWS"
  type        = string
  default     = "t3.small"
}

variable "aws_test_ec2_size" {
  description = "Size of instances that will be deployed per spoke VPC in AWS"
  type        = string
  default     = "t3.nano"
}

variable "aws_key_name" {
  description = "Key name of your previously generated instance key - used to connect to Linux EC2 test instances"
  type        = string
  default     = "aviatrix-lab-aws"
}

variable "aws_iam_bootstrap_role" {
  description = "IAM Role used to access bootstrap file in S3 bucket"
  type        = string
  default     = ""
}

variable "aws_bootstrap_bucket" {
  description = "Name of the S3 bucket that contains the bootstrap file"
  type        = string
  default     = ""
}

variable "deploy_azure" {
  description = "Deploy Azure as part of the Multi-Cloud Transit"
  type        = bool
  default     = true
}

variable "azure_prefix" {
  description = "Prefix used for resources in Azure"
  type        = string
  default     = "azr"
}

variable "azure_region" {
  description = "Azure region where we will deploy VNets, Aviatrix Gateways, and Virtual Machines"
  type        = string
  default     = "France Central"
}

variable "azure_region_short" {
  description = "Short format to indicate Azure region in VNets and Gateways names"
  type        = string
  default     = "frct"
}

variable "azure_account_name" {
  description = "Name of your Azure account in the Aviatrix Controller"
  type        = string
}

variable "azure_resource_group" {
  description = "Resource Group to use in your Azure Account"
  type        = string
}

variable "azure_transit_cidr" {
  description = "CIDR used for the Azure Transit VNet"
  type        = string
  default     = "10.2.0.0/23"
}

variable "azure_spoke_cidr_list" {
  description = "CIDR blocks for the Spoke VNets in Azure"
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
}

variable "azure_test_vm_hostnum" {
  description = "Defines the host number / IP address of the test VM in a Spoke VPC in Azure"
  type        = number
  default     = 13
}

variable "azure_transit_gateway_size" {
  description = "VM size used for Aviatrix Transit Gateways on Azure"
  type        = string
  default     = "Standard_B2s"
}

variable "azure_firenet_gateway_size" {
  description = "Instance size used for Aviatrix Transit Gateways on Azure"
  type        = string
  default     = "Standard_B2ms"
}

variable "azure_firewall_size" {
  description = "Instance size used for Aviatrix Spoke Gateways on Azure"
  type        = string
  default     = "Standard_D3_v2"
}

variable "azure_spoke_gateway_size" {
  description = "VM size used for Aviatrix Spoke Gateways on Azure"
  type        = string
  default     = "Standard_B2s"
}

variable "azure_test_vm_size" {
  description = "Size of VMs that will be deployed per Spoke VPC in Azure"
  type        = string
  default     = "Standard_B1ls"
}

variable "azure_test_vm_user" {
  description = "User name used on test VMs on Azure"
  type        = string
  default     = "azure-user"
}

variable "azure_key_name" {
  description = "Key name of your previously generated instance key - used to connect to Linux test VMs"
  type        = string
  default     = "aviatrix-lab-azure"
}

variable "azure_public_key_path" {
  description = "Path of your previously generated instance key - used to connect to Linux EC2 test instances"
  type        = string
  default     = "~/.ssh/"
}

variable "azure_bootstrap_storage" {
  description = "Azure Storage Account used to store PAN FW bootstrap files"
  type        = string
  default     = ""
}

variable "azure_bootstrap_storage_access_key" {
  description = "Access Key to the Azure Storage Account used to store PAN FW bootstrap files"
  type        = string
  default     = ""
}

variable "azure_bootstrap_file_share_folder" {
  description = "Azure File Storage used to store PAN FW bootstrap files"
  type        = string
  default     = ""
}

variable "deploy_gcp" {
  description = "Deploy GCP as part of the Multi-Cloud Transit"
  type        = bool
  default     = true
}

variable "gcp_prefix" {
  description = "Prefix used for resources in GCP"
  type        = string
  default     = "gcp"
}

variable "gcp_region" {
  description = "GCP region where we will deploy Subnets, Aviatrix Gateways, and GCE Instances"
  type        = string
  default     = "europe-west1"
}

variable "gcp_region_short" {
  description = "Short format to indicate GCP region in Subnets and Gateways names"
  type        = string
  default     = "euw1"
}

variable "gcp_zone" {
  description = "GCP zone where we will deploy GCE Instances"
  type        = string
  default     = "europe-west1-b"
}

variable "gcp_account_name" {
  description = "Name of your GCP account in the Aviatrix Controller"
  type        = string
}

variable "gcp_project" {
  description = "Project to use in your GCP Account"
  type        = string
}

variable "gcp_transit_cidr" {
  description = "CIDR used for the GCP Transit VPCs/Subnets"
  type        = string
  default     = "10.3.0.0/23"
}

variable "gcp_firewall_cidr" {
  description = "CIDR used for the GCP Firewall VPCs/Subnets (when FireNet is enabled)"
  type        = string
  default     = "10.3.2.0/23"
}

variable "gcp_spoke_cidr_list" {
  description = "CIDR blocks for the Spoke VPCs/Subnets in Azure"
  type        = list(string)
  default     = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
}

variable "gcp_test_instance_hostnum" {
  description = "Defines the host number / IP address of the test instance in a Spoke VPC/Subnet in GCP"
  type        = number
  default     = 5
}

variable "gcp_transit_gateway_size" {
  description = "Instance size used for Aviatrix Transit Gateways on GCP"
  type        = string
  default     = "n1-standard-1"
}

variable "gcp_firenet_gateway_size" {
  description = "Instance size used for Aviatrix Transit Gateways on GCP"
  type        = string
  default     = "n1-standard-1"
}

variable "gcp_firewall_size" {
  description = "Instance size used for Aviatrix Spoke Gateways on GCP"
  type        = string
  default     = "n1-standard-4"
}

variable "gcp_spoke_gateway_size" {
  description = "Instance size used for Aviatrix Spoke Gateways on GCP"
  type        = string
  default     = "n1-standard-1"
}

variable "gcp_test_instance_size" {
  description = "Size of instances that will be deployed per Spoke VPC/Subnet in GCP"
  type        = string
  default     = "f1-micro"
}

variable "enable_firenet_on_aws" {
  description = "Enable Transit FireNet on AWS"
  type        = bool
  default     = false
}

variable "deploy_firenet_on_aws" {
  description = "Deploy Transit FireNet on AWS"
  type        = bool
  default     = false
}

variable "use_aws_gwlb" {
  description = "Enable GWLB for Transit FireNet on AWS"
  type        = bool
  default     = false
}

variable "enable_firenet_on_azure" {
  description = "Make sure Transit FireNet is enabled on Azure Transit (VNet/GW ready for a FW to be deployed)"
  type        = bool
  default     = false
}

variable "deploy_firenet_on_azure" {
  description = "Deploy Transit FireNet on Azure"
  type        = bool
  default     = false
}

variable "deploy_firenet_on_gcp" {
  description = "Deploy Transit FireNet on GCP"
  type        = bool
  default     = false
}

variable "deploy_checkpoint_fw" {
  description = "Deploy Checkpoint FW rather than Palo Alto"
  type        = bool
  default     = false
}

variable "checkpoint_user_data_file" {
  description = "Local file with User Data to bootstrap Checkpoint FW"
  type        = string
  default     = "./User Data/user_data_checkpoint.sh"
}

variable "egress_transit_firenet" {
  description = "Enable Egress through Transit FireNet"
  type        = bool
  default     = false
}

variable "fw_username" {
  description = "Username used for FireNet Vendor Integration"
  type        = string
  default     = ""
}

variable "fw_password" {
  description = "Username used for FireNet Vendor Integration"
  type        = string
  default     = ""
}

variable "enable_s2c_on_aws" {
  description = "Enable Site-2-Cloud on AWS"
  type        = bool
  default     = true
}

variable "transit_ha" {
  description = "Enable HA for Aviatrix Transit Gateways"
  type        = bool
  default     = true
}

variable "spoke_ha" {
  description = "Enable HA for all Aviatrix Spoke Gateways"
  type        = bool
  default     = false
}

variable "spoke_ha_first_vpc_only" {
  description = "Enable HA only for the Aviatrix Spoke Gateway in the first VPC/VNet of each CSP"
  type        = bool
  default     = true
}

variable "hpe" {
  description = "Enable HPE / Insane Mode on Gateways"
  type        = bool
  default     = false
}

variable "source_nat_on_spoke" {
  description = "Enable Single IP Source NAT on Spoke Gateways"
  type        = bool
  default     = false
}

variable "segmentation" {
  description = "Enable Segmentation for Aviatrix Transit Gateways"
  type        = bool
  default     = true
}

variable "network_domain_list" {
  description = "Network Domains for the Spoke VPC/VNets"
  type        = list(string)
  default     = ["prod", "dev", "shared"]
}

variable "customer_prefix" {
  description = "Prefix used for all resources, to identify a specific customer"
  type        = string
  default     = "avx-"
}

variable "spoke_name_list" {
  description = "Names for the Spoke VPC/VNets"
  type        = list(string)
  default     = ["prod", "dev", "shared"]
}

variable "aws_jumphost_target_spoke_vpc" {
  description = "Index of spoke_name_list that indicates which VPC the jumphost public EC2 instance will be placed into"
  type        = number
  default     = 2
}

variable "aws_linux2_on_aws_ec2" {
  description = "Use the AWS Linux2 AMI for AWS EC2 test instances"
  type        = bool
  default     = true
}

variable "aws_linux2_user_data_file" {
  description = "Name of the local file used for Linux Instances User Data in AWS"
  type        = string
  default     = "./User Data/user_data_aws_linux2.sh"
}

variable "ubuntu_user_data_file" {
  description = "Name of the local file used for Linux VM/Instances User Data"
  type        = string
  default     = "./User Data/user_data_ubuntu.sh"
}

variable "tags" {
  description = "Tags added to each provisionned construct"
  type        = map(string)
  default = {
    Environment = "avx-mcna-as-code"
  }
}

locals {
  aws_jumphost_spoke_vpc       = min(length(var.spoke_name_list) - 1, var.aws_jumphost_target_spoke_vpc)
  aws_test_ec2_jumphostnum     = var.aws_test_ec2_hostnum + 8
  aws_test_ec2_jumphostnum_bis = var.aws_test_ec2_hostnum + 3
  aws_user_data_file           = var.aws_linux2_on_aws_ec2 ? var.aws_linux2_user_data_file : var.ubuntu_user_data_file
  user_data_file               = var.ubuntu_user_data_file
  azure_public_key             = "${var.azure_public_key_path}${var.azure_key_name}.pub"
  my_ip_address                = "${chomp(data.http.icanhazip.body)}/32"
}
