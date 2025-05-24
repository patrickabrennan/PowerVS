terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.57.0"
    }
  }
  required_version = ">= 1.12.1"
}

provider "ibm" {
  ibmcloud_api_key   = "obrSTjaKwv25WyqZXxBFWYiwhq0mIPk43aq4weVJ1F0v"
  region = "us-south"
  #zone = "us-south"
}

resource "ibm_pi_resource_instance" "powervs_workspace" {
      name          = "my-powervs-workspace" #  (Required) Name of the PowerVS workspace
      resource_group = "my-resource-group" # (Required) Resource group where the workspace will be created
      service_name  = "power-iaas"          # (Required) Service name for Power Virtual Server (PVS)
      plan_name     = "power-virtual-server-group"  # (Required)  Choose the appropriate plan, for clients it's "power-virtual-server-private-group"
      # Optionally, you can specify other parameters like:
      zone         = "us-south"     # (Optional) Data center zone
      region       = "us-south"   # (Optional) Region
}

#Create a subnet
resource "ibm_pi_network" "my_subnet" { 
  pi_cloud_instance_id	= "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
  pi_network_name	= "test-subnet"
  pi_network_type	= "vlan"
  pi_network_mtu       = "9000"
  pi_cidr		= "10.1.0.0/24"
  pi_gateway  = "10.1.0.1"
  pi_dns = ["8.8.8.8"]
}

#data "ibm_pi_public_network" "my_subnet" {
#  pi_cloud_instance_id	= "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
#}

resource "ibm_pi_instance" "my_instance" {
  pi_memory		= 4
  pi_processors		= 0.25
  pi_instance_name	= "test_rhel_instance"
  pi_proc_type		= "shared"
  pi_image_id 		= "7300-03-00"
  pi_sys_type		= "s922"
  pi_cloud_instance_id	= "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
  pi_network {
   network_id = ibm_pi_network.my_subnet.network_id
   #network_id = data.ibm_pi_public_network.my_subnet.id
  }
}

#create Volume
resource "ibm_pi_volume" "test_volume" {
  pi_cloud_instance_id	= "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
  pi_volume_size	= 2
  pi_volume_name	= "test_volume"
  pi_volume_type	= "tier3" 
}

resource "ibm_pi_volume_attach" "test_volume" {
  pi_cloud_instance_id	= "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
  pi_volume_id = ibm_pi_volume.test_volume.volume_id
  pi_instance_id = ibm_pi_instance.my_instance.instance_id
}

resource "pi_ssh_public_key" "ssh_key" {
  pi_cloud_instance_id = "643dac51-7891-4c2f-abc5-6ddeb680e2ad"
  pi_key_name          = "powervs-ssh-public"
  pi_ssh_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZUw1yvE8A15vPk48W637EjMi/xAtugZJRyxHzmNvcsPRgkJ2ox7owgf3vJNC20yzcArV83uPZnec7lfjfWggVBpI/VETgaeeGC1UB6ilu0WO6MPD5BpVhg5HknMXtaVfmQHdG3Ycw0Ilg8DGFWjTRneTV7mpu00TYQZELBrShE9iVG5RCVQ3Fka8xt9wnCVYj/Qjo4VQyfi36zJe47/XH/Oji2ANVijpPMKHPYQizrm0t/WTdzy2iSFUJhHRqOjjQx79KTWIks2ig3jSFguzztwYKmxDRbb7M7AHS1qutVr5MSeJSxtneNYLYgxwKOx5el0zXIqD/a4ow4TlZJDjStnTFg+RaHXJ4E8sJ6zWEmIlisjKgVPpud1MPkUxRO7kuxiZ37/TxaTkVLDGWylTtNAdQj+ih2h+FtPtHE3VJkOIAI3FTX1GSEdTQoH5eEs/xgLYCIg4ANcSEOoyaJqVgFnQInmXuXd0Hq391AMcOmWugPCioVHcJeanSSeQxw0M= sap"
}

#resource "ibm_is_floating_ip" "fip1" {
#  name   = "fip1"
#  target = ibm_pi_instance.my_instance.id
#}

#resource "ibm_is_floating_ip" "fip1" {
#  name = "fip1"
#  target = ibm_pi_instance.my_instance.network_id
#}

#output "sshcommand" {
#  value = "ssh root@${ibm_pi_floating_ip.fip1.address}"
#}
