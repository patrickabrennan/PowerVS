# IBM Power Examples
This directory contains sample Terraform code to create a Power Systems Virtual Server.
​
## Prerequisites
- An HCP Terrform Account (https://developer.hashicorp.com/terraform/cloud-docs)
- An [IBM Cloud Account](https://cloud.ibm.com/registration)
- An IBM Cloud [IAM API key](https://cloud.ibm.com/docs/account?topic=account-userapikey)
​
## Terraform values to be set
ibmcloud_api_key
pi_ssh_key 

## Setup
The following are for setting up the example terraform for use in HCP Terraform:
 - Clone this repo into your GitHub account.
 - Modify the variables in `variables.tf` as needed or use as-is (see below for for the defaults) 
 - In HCP Terraform create a project if not using an exist one and then create a workspace
 - Connect the HCP Workspace to your repo 
 - All variables have detault vaults, so you will be prompted for your IBM Cloud API key. Enter it and save. 
 - Perform a terraform run. It will create a plan and apply
 - 
```bash
## Documentation
 - [IBM Power Systems Virtual Server Docs](https://cloud.ibm.com/docs/power-iaas?topic=power-iaas-getting-started)
 - [Intro to Terraform](https://www.terraform.io/intro) | [Terraform Overview](https://www.terraform.io/language)
 - [Terraform SDK Docs](https://pkg.go.dev/github.com/hashicorp/terraform-plugin-sdk) (For devs contributing to repo)
​
##Default values in variable.tf 
region  = "us-south"
zone = "us-south"
workspace-name = "Demo"
pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
pi_network_name	= "subnet-1"
pi_network_type = "vlan"
pi_cidr		= "10.1.0.0/24"
pi_gateway  = "10.1.0.1"
#pi_dns = ["8.8.8.8"]
pi_memory		= 4
pi_processors		= 0.25
pi_instance_name	= "AIX_instance"
pi_proc_type		= "shared"
pi_image_id 		= "7300-03-00"
pi_sys_type		= "s922"
pi_volume_size	= 100
pi_volume_name	= "test_volume"
pi_volume_type	= "tier3"
pi_key_name       = "powervs-ssh"
pi_ssh_key
                                                                  ```bash
## Documentation
 - [IBM Power Systems Virtual Server Docs](https://cloud.ibm.com/docs/power-iaas?topic=power-iaas-getting-started)
 - [Intro to Terraform](https://www.terraform.io/intro) | [Terraform Overview](https://www.terraform.io/language)
 - [Terraform SDK Docs](https://pkg.go.dev/github.com/hashicorp/terraform-plugin-sdk) (For devs contributing to repo)
​
## IBM Power Systems Terraform Docs
> [Link](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_capture) to IBM Terrafom Docs


| Resource Type | Resource Docs | Data Source Docs |
| :------------ |:------------- | :--------------- |
| Capture | [ibm_pi_capture](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_capture) |  |
| Cloud Connection | [ibm_pi_cloud_connection](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection)<br>[ibm_pi_cloud_connection_network_attach](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_cloud_connection_network_attach) | [ibm_pi_cloud_connection](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_cloud_connection)<br>[ibm_pi_cloud_connections](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_cloud_connections) |
| Cloud Instance |  | [ibm_pi_cloud_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_cloud_instance) |
| DHCP | [ibm_pi_dhcp](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_dhcp) | [ibm_pi_dhcp](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_dhcp)<br>[ibm_pi_dhcps](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_dhcps) |
| Image | [ibm_pi_image](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_image)<br>[image_export](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_image_export) | [ibm_pi_catalog_images](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_catalog_images)<br>[ibm_pi_image](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_image)<br>[ibm_pi_images](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_images) |
| Instance | [ibm_pi_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_instance)<br>[ibm_pi_instance_console_language](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_console_language)<br>[ibm_pi_snapshot](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_snapshot) | [ibm_pi_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_instance)<br>[ibm_pi_instances](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_instances)<br>[ibm_pi_instance_console_languages](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_console_languages)<br>[ibm_pi_instance_ip](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_instance_i)<br>[ibm_pi_snapshot](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_pvm_snapshots)<br>[ibm_pi_snapshots](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_pvm_snapshots) |
| Key | [ibm_pi_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_key) | [ibm_pi_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_key)<br>[ibm_pi_keys](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_keys) |
| Network | [ibm_pi_network](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_network)<br>[ibm_pi_network_port](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_network_port)<br>[ibm_pi_network_port_attach](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_network) | [ibm_pi_network](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_network)<br>[ibm_pi_network_port](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_network)<br>[ibm_pi_public_network](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_public_network) |
| Placement Group | [ibm_pi_placement_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_placement_group) | [ibm_pi_placement group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_placement_group)<br>[ibm_pi_placement_groups](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_placement_groups) |
| SAP | | [ibm_pi_sap_profile](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_sap_profile)<br>[ibm_pi_sap_profiles](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_sap_profiles) |
| Storage Capacity | | [ibm_pi_storage_pool_capacity](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_storage_pool_capacity)<br>[ibm_pi_storage_pools_capacity](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_storage_pools_capacity)<br>[ibm_pi_system_pools]() |
| Storage Type | | [ibm_pi_storage_type_capacity](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_storage_type_capacity)<br>[ibm_pi_storage_types_capacity](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_storage_types_capacity) |
| Tenant | | [ibm_pi_tenant](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_tenant) |
| Volume | [ibm_pi_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_volume)<br>[ibm_pi_volume_attach](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_volume_attach) | [ibm_pi_instance_volumes](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_instance_volumes)<br>[ibm_pi_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/pi_volume) |
| VPN | [ibm_pi_ike_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_vpn_ike_policy)<br>[ibm_pi_ipsec_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_vpn_ipsec_policy)<br>[ibm_pi_vpn_connection](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/pi_vpn_connection) |  |
