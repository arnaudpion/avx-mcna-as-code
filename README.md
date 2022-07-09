# avx-mcna-as-code
Terraform code to deploy an Aviatrix Multi-Cloud Network Architecture (MCNA) environment for labs and demos.

## What the code does
With the default values, the code will deploy Hub & Spoke topologies in AWS, Azure and GCP, with a Transit VPC/VNet and three Spoke VPCs/VNets (Prod/Dev/Shared) in each Cloud. Aviatrix Gateways are deployed in the Transit and the Prod Spoke with HA, and in the Dev and Shared Spokes without HA. Transit VPCs/VNets are peered to each other to build the Multi-Cloud Network Architecture. The code also deploys another Transit VPC in a different region to simulate a Data Center connected to AWS through Site-to-Cloud (BGP over IPSec).

Each Spoke VPC/VNet, as well as the Site-to-Cloud Transit, contains an instance/VM that is configured to send traffic to the other instances/VMs in the network. An additional Jump Host / Bastion Host is deployed in the third AWS Spoke VPC, allowing SSH access from the Internet (restricted to the IP address of the workstation running the code), in order to connect to the instances/VMs of the environment. The public IP address of this Jump Host is provided as an output of the code.

Adjusting the variables allows for various customization :
* Add or remove Spoke VPCs/VNets
* Remove S2C
* Enable / disable HA
* Enable services such as HPE, FireNet, Single IP Source NAT,...

## Architecture diagram (default values) :
<img width="877" alt="image" src="https://user-images.githubusercontent.com/16352524/161223956-20c8643c-c9ab-49d9-90e3-4308faac99f0.png">

## Architecture diagram with network domains :
<img width="874" alt="image" src="https://user-images.githubusercontent.com/16352524/161223995-9086adfa-03de-412f-9765-dae946d701ab.png">

## Prerequisites
 * Aviatrix Controller already deployed and configured with CSP accounts. The following variables should be added in a terraform.tfvars file :
   * <b>aws_account_name</b>     = "<AWS_account_name_in_the_controller>"
   * <b>azure_account_name</b>   = "<Azure_account_name_in_the_controller>"
   * <b>azure_resource_group</b> = "<Azure_resource_group_to_be_used>"
   * <b>gcp_account_name</b>     = "<GCP_account_name_in_the_controller>"
   * <b>gcp_project</b>          = "<GCP_project_to_be_used>"
 * Providers variables provided through environment variables :
   * <b>AVIATRIX_CONTROLLER_IP, AVIATRIX_USERNAME, AVIATRIX_PASSWORD</b> - please refer to https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs#environment-variables
   * <b>AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY</b> - please refer to https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables / https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html
   * <b>ARM_SUBSCRIPTION_ID, ARM_TENANT_ID, ARM_CLIENT_ID</b> - please refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference / https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
   * <b>GOOGLE_APPLICATION_CREDENTIALS</b> (<b>GOOGLE_CREDENTIALS</b> in Terraform Cloud) - please refer to https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference / https://cloud.google.com/docs/authentication/getting-started
 * Existing EC2 Key Pair in each AWS region : default key pair name '<i>aviatrix-lab-aws</i>', default AWS regions '<i>us-east-1</i>' and '<i>us-west-2</i>' - for more information, please refer to https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
 * Existing SSH public-private key pair for Linux VMs in Azure : default key name '<i>aviatrix-lab-azure</i>', located in ~/.ssh/ (MacOS) - for more information, please refer to https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed
 * Please make sure you select the Aviatrix provider version compatible with your Aviatrix Controller release : https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs/guides/release-compatibility

## Tested versions
 * Aviatrix Controller release 6.7.1319
 * Terraform Aviatrix provider 2.22.1

 ## Known caveats
 * FireNet is only available on AWS, with Palo-Alto VM-Series
 * FireNet support on Azure and GCP, and with other NGFW vendors, is planned in the future

## Additional comments
* The content of the "<i>user_data*.sh</i>" files is static. If the "<i>hostnum</i>" variables are changed, or if you add more Spoke VPCs/VNets, you will have to modify the <i>/etc/hosts</i> data in these files for the DNS lookup to work as intended
* To deploy FireNet, first you need to subscribe to the right NGFW offer in the target CSP Marketplace. You'll also need to update some variables and deal with the bootstrap. You can refer to https://docs.aviatrix.com/HowTos/bootstrap_example.html / https://docs.aviatrix.com/HowTos/pan_bootstrap_example_azure.html / https://docs.aviatrix.com/HowTos/checkpoint_bootstrap_azure.html
