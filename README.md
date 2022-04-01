# avx-mcna-as-code
Terraform code to deploy an Aviatrix Multi-Cloud Network Architecture (MCNA) environment for labs and demos.

## What the code does
With the default values, the code will deploy Hub & Spoke topologies in AWS, Azure and GCP, with a Transit VPC/VNet and three Spoke VPCs/VNets (Prod/Dev/Shared) in each Cloud. Aviatrix Gateways are deployed in the Transit and the Prod Spoke with HA, and in the Dev and Shared Spokes without HA. The code also deploys another Transit VPC in a different region to simulate a Data Center connected to AWS through Site-to-Cloud (BGP over IPSec).

Each Spoke VPC/VNet, as well as the Site-to-Cloud Transit, contains an instance/VM that is configured to send traffic to the other instances/VMs in the network. An additional Jump Host / Bastion Host is deployed in the third AWS Spoke VPC, allowing SSH access from the Internet (restricted to the IP address of the workstation running the code), in order to connect to the instances/VMs of the environment. The public IP address of this Jump Host is provided as an output of the code.

Adjusting the variables allows for various customization :
* Add or remove Spoke VPCs/VNets
* Remove S2C
* Enable / disable HA
* Enable services such as HPE, FireNet, Single IP Source NAT,...

## Architecture diagram (default values) :
<img width="877" alt="image" src="https://user-images.githubusercontent.com/16352524/161223956-20c8643c-c9ab-49d9-90e3-4308faac99f0.png">

## Architecture diagram with segmentation domains :
<img width="874" alt="image" src="https://user-images.githubusercontent.com/16352524/161223995-9086adfa-03de-412f-9765-dae946d701ab.png">

## Prerequisites
 * Aviatrix Controller already deployed and configured with CSP accounts. The following variables should be added in a terraform.tfvars file :
   * aws_account_name    = "<AWS_account_name_in_the_controller>"
   * azure_account_name   = "<Azure_account_name_in_the_controller>"
   * azure_resource_group = "<Azure_resource_group_to_be_used>"
   * gcp_account_name    = "<GCP_account_name_in_the_controller>"
   * gcp_project         = "<GCP_project_to_be_used>"
 * Providers variables provided through environment variables :
   * AVIATRIX_CONTROLLER_IP, AVIATRIX_USERNAME, AVIATRIX_PASSWORD - please refer to https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs#environment-variables
   * AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY - please refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables / https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
   * ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID - please refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference / https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
   * GOOGLE_APPLICATION_CREDENTIALS (GOOGLE_CREDENTIALS in Terraform Cloud) - please refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference / https://cloud.google.com/docs/authentication/getting-started
 * Existing EC2 Key Pair in each AWS region : default key pair name 'aviatrix-lab-aws', default AWS regions 'us-east-1' and 'us-west-2' - for more information, please refer to https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
 * Existing SSH public-private key pair for Linux VMs in Azure : default key name 'aviatrix-lab-azure', located in ~/.ssh/ (MacOS) - for more information, please refer to https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed
 * Please make sure you select the Aviatrix provider version compatible with your Aviatrix Controller release : https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/guides/release-compatibility

## Additional comments
* "user_data*.sh" content is static. If the "hostnum" variables are changed, or if you add more Spoke VPCs/VNets, you will have to modify the /etc/hosts data in these file for the DNS lookup to work as intended
* To deploy FireNet, first you need to subscribe to the right NGFW offer in the target CSP Marketplace. You'll also need to update some variables and deal with the bootstrap. You can refer to https://docs.aviatrix.com/HowTos/bootstrap_example.html / https://docs.aviatrix.com/HowTos/pan_bootstrap_example_azure.html / https://docs.aviatrix.com/HowTos/checkpoint_bootstrap_azure.html
