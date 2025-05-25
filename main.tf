terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.71.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key   = "obrSTjaKwv25WyqZXxBFWYiwhq0mIPk43aq4weVJ1F0v"
  region = "us-south"
  zone = "us-south"
}

#resource "ibm_pi_workspace" "powervs_service_instance" {
#  pi_name               = "PowerVS-demo"
#  pi_datacenter         = "us-south"
#  pi_resource_group_id  = data.ibm_resource_group.group.id
#  pi_plan               = "public"
#}

#Create a subnet
resource "ibm_pi_network" "my_subnet" { 
  pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
  pi_network_name	= "test-subnet"
  pi_network_type	= "vlan"
  pi_network_mtu       = "9000"
  pi_cidr		= "10.1.0.0/24"
  pi_gateway  = "10.1.0.1"
  pi_dns = ["8.8.8.8"]
}

resource "ibm_pi_instance" "my_instance" {
  pi_memory		= 4
  pi_processors		= 0.25
  pi_instance_name	= "test_rhel_instance"
  pi_proc_type		= "shared"
  pi_image_id 		= "7300-03-00"
  pi_sys_type		= "s922"
  pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
  #pi_key_pair_name = "PowerVS-ssh"
  pi_network {
   network_id = ibm_pi_network.my_subnet.network_id
  }
}

#create Volume
resource "ibm_pi_volume" "test_volume" {
  pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
  pi_volume_size	= 100
  pi_volume_name	= "test_volume"
  pi_volume_type	= "tier3" 
}

resource "ibm_pi_volume_attach" "test_volume" {
  pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
  pi_volume_id = ibm_pi_volume.test_volume.volume_id
  pi_instance_id = ibm_pi_instance.my_instance.instance_id
}

resource "ibm_pi_key" "PowerVS_sshkey" {
  name       = "powervs-ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZUw1yvE8A15vPk48W637EjMi/xAtugZJRyxHzmNvcsPRgkJ2ox7owgf3vJNC20yzcArV83uPZnec7lfjfWggVBpI/VETgaeeGC1UB6ilu0WO6MPD5BpVhg5HknMXtaVfmQHdG3Ycw0Ilg8DGFWjTRneTV7mpu00TYQZELBrShE9iVG5RCVQ3Fka8xt9wnCVYj/Qjo4VQyfi36zJe47/XH/Oji2ANVijpPMKHPYQizrm0t/WTdzy2iSFUJhHRqOjjQx79KTWIks2ig3jSFguzztwYKmxDRbb7M7AHS1qutVr5MSeJSxtneNYLYgxwKOx5el0zXIqD/a4ow4TlZJDjStnTFg+RaHXJ4E8sJ6zWEmIlisjKgVPpud1MPkUxRO7kuxiZ37/TxaTkVLDGWylTtNAdQj+ih2h+FtPtHE3VJkOIAI3FTX1GSEdTQoH5eEs/xgLYCIg4ANcSEOoyaJqVgFnQInmXuXd0Hq391AMcOmWugPCioVHcJeanSSeQxw0M= sap"
  pi_cloud_instance_id	= "10f21edf-47a3-454f-b2a3-e1032b4ea6c5"
}


#resource "ibm_is_floating_ip" "fip1" {
#  name = "fip1"
#  target = ibm_pi_instance.my_instance.network_id
#  crn = "crn:v1:bluemix:public:power-iaas:us-south:a/9568b7d56c7f48399bf8580557b5f022:10f21edf-47a3-454f-b2a3-e1032b4ea6c5:pvm-instance:01f8706c-8589-4f1f-b13b-ae5b67bd80d0"
#}

#output "sshcommand" {
#  value = "ssh root@${ibm_pi_floating_ip.fip1.address}"
#}
