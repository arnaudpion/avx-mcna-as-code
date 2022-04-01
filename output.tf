output "aws_jumphost_public_IP" {
  description = "Public IP address of the AWS EC2 jump host instance"
  value       = var.deploy_aws ? aws_instance.jump-host[0].public_ip : null
}