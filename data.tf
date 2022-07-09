# AWS Availability Zones in the Region
data "aws_availability_zones" "available" {
  state = "available"
}

# AWS Linux 2 AMI
data "aws_ami" "aws-linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# AWS Ubuntu AMI
data "aws_ami" "aws-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# AWS Availability Zones in the S2C Region
data "aws_availability_zones" "available_s2c" {
  provider = aws.s2c
  state    = "available"
}

# AWS Linux 2 AMI
data "aws_ami" "aws-linux2_s2c" {
  provider    = aws.s2c
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Aviatrix FireNet Vendor Integration Data Source
data "aviatrix_firenet_vendor_integration" "aws_fw_integration" {
  count = var.deploy_aws ? (var.deploy_firenet_on_aws ? (var.use_aws_gwlb ? 0 : (var.transit_ha ? 2 : 1)) : 0) : 0

  vpc_id        = module.transit_aws[0].vpc.vpc_id
  instance_id   = module.firenet_aws[0].aviatrix_firewall_instance[0].instance_id
  vendor_type   = var.deploy_checkpoint_fw ? "Generic" : "Palo Alto Networks VM-Series"
  public_ip     = module.firenet_aws[0].aviatrix_firewall_instance[0].public_ip
  username      = var.fw_username
  password      = var.fw_password
  firewall_name = module.firenet_aws[0].aviatrix_firewall_instance[0].firewall_name
  save          = true

  depends_on = [time_sleep.wait_for_fw_to_come_up]
}

/*
data "aviatrix_firenet_vendor_integration" "azure_fw_integration" {
  count = var.enable_firenet_on_azure ? (var.transit_ha ? 2 : 1) : 0

  vpc_id        = module.transit_firenet_azure[0].vnet.vpc_id
  instance_id   = module.transit_firenet_azure[0].aviatrix_firewall_instance[count.index].instance_id
  vendor_type   = "Palo Alto Networks VM-Series"
  public_ip     = module.transit_firenet_azure[0].aviatrix_firewall_instance[count.index].public_ip
  username      = var.fw_username
  password      = var.fw_password
  firewall_name = module.transit_firenet_azure[0].aviatrix_firewall_instance[count.index].firewall_name
  save          = true

  depends_on = [
    time_sleep.wait_for_fw_to_come_up,
    time_sleep.wait_for_fw_to_come_up_in_azure
  ]
}
*/

# Data template Bash bootstrapping file for Azure VMs
data "template_file" "linux_vm_cloud_init" {
  template = file(local.user_data_file)
}

# User Data to bootstrap Checkpoint FW
data "template_file" "checkpoint_fw_init" {
  template = file(var.checkpoint_user_data_file)
}

# Public IP Address of your workstation, to allow SSH access to test instances (used in AWS Security Groups definition)
data "http" "icanhazip" {
  url = "http://ipv4.icanhazip.com"
}