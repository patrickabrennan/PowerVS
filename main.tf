terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.71.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
  region= var.region
  zone = var.zone
}

data "ibm_resource_group" "group" {
  name = "Default"
}

data "ibm_resource_instance" "powervs" {
  name = var.workspace-name
  service = "power-iaas"
  location = var.region
  depends_on = [ ibm_pi_workspace.powervs_service_instance ]
}

output "pi_cloud_instance_id" {
  value = data.ibm_resource_instance.powervs.guid
}

resource "ibm_pi_workspace" "powervs_service_instance" {
  pi_name               = var.workspace-name
  pi_datacenter         = var.region
  pi_resource_group_id  = data.ibm_resource_group.group.id
}

#Create a subnet
resource "ibm_pi_network" "my_subnet" { 
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_network_name	= var.pi_network_name
  pi_network_type	= var.pi_network_type
  pi_network_mtu       = "9000"
  pi_cidr		= var.pi_cidr
  #pi_gateway  = var.pi_gateway
  pi_dns = ["8.8.8.8"]
}

resource "ibm_pi_instance" "my_instance" {
  pi_memory		= var.pi_memory
  pi_processors		= var.pi_processors
  pi_instance_name	= var.pi_instance_name
  pi_proc_type		= var.pi_proc_type
  pi_image_id 		= var.pi_image_id
  pi_sys_type		= var.pi_sys_type
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_key_pair_name = var.pi_key_name
  pi_network {
   network_id = ibm_pi_network.my_subnet.network_id
  }
}

#create Volume
resource "ibm_pi_volume" "test_volume" {
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_volume_size	= var.pi_volume_size
  pi_volume_name	= var.pi_volume_name
  pi_volume_type	= var.pi_volume_type 
}

resource "ibm_pi_volume_attach" "test_volume" {
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid   #var.pi_cloud_instance_id
  pi_volume_id = ibm_pi_volume.test_volume.volume_id
  pi_instance_id = ibm_pi_instance.my_instance.instance_id
}

resource "ibm_security_group" "sg1" {
    name = "sg1"
    description = "allow my app traffic"
}

resource "ibm_security_group_rule" "allow_port_22" {
    direction = "ingress"
    ether_type = "IPv4"
    port_range_min = 22
    port_range_max = 22
    protocol = "tcp"
    security_group_id = ibm_security_group.sg1.id
}

resource "ibm_pi_key" "PowerVS_sshkey" {
  pi_key_name       = var.pi_key_name
  pi_ssh_key = var.pi_ssh_key
  pi_cloud_instance_id	= data.ibm_resource_instance.powervs.guid  #var.pi_cloud_instance_id
}
