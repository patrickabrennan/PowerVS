terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.57.0"
    }
  }
  required_version = ">= 1.5.7"
}

provider "ibm" {
  ibmcloud_api_key   = "obrSTjaKwv25WyqZXxBFWYiwhq0mIPk43aq4weVJ1F0v"
  region = "dal"
  zone = "dal13"
}

data "ibm_pi_instance" "example" {
  instance_id = ibm_pi_instance.example.id
}

#Create a subnet
resource "ibm_pi_network" "my_subnet" { 
  pi_cloud_instance_id	= "instance_id"
  pi_network_name	= "test-subnet"
  pi_network_type	= "vlan"
  pi_cidr		= "192.1689.1.0/24"
}

#create Volume
resource "ibm_pi_volume" "test_volume" {
  pi_cloud_instance_id	= "instance_id"
  pi_volume_size	= 2
  pi_volume_name	= "test_volume"
  pi_volume_type	= "tier 3" 
}

resource "ibm_pi_instance" "my_instance" {
  pi_memory		= 4
  pi_processors		= 0.25
  pi_instance_name	= "test_rhel_instance"
  pi_proc_type		= "shared"
  pi_image_id 		= "df5OB543-b385-4ee8-ad4d-b4ede88be392"
  pi_sys_type		= "s922"
  pi_cloud_instance_id	= "instance_id"
  pi_network {
   network_id = ibm_pi_network.my_subnet.network_id
  }
}

resource "ibm_pi_volume_attach" "test_volume" {
  pi_cloud_instance_id	= "instance_id"
  pi_volume_id = ibm_pi_volume.test_volume.ivolume_id
  pi_instance_id = ibm_pi_instance.my_instance.instance_id
}
