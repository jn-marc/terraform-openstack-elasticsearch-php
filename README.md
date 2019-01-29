# Terraform demo on Openstack to launch a php application with Elasticsearch Cluster

To use this terraform, create a file named credentials.tf.

Insert your OpenStack credentials and Auth URL as below ( Replace the My_OS_* default values):


    variable "openstack_username" {
      type    = "string"
      default = "My_OS_Username"
    }

    variable "openstack_password" {
      type    = "string"
      default = "My_OS_Password"
    }

    variable "openstack_project" {
      type    = "string"
      default = "My_OS_Tenant_Name"
    }

    variable "openstack_auth_url" {
      type    = "string"
      default = "My_OS_Auth_URL"
    }


You can also customize de variables.tf, by restricting ssh access to the rebond instance. Replace 0.0.0.0/0 by your  public IP to allow ssh connect to the rebond to this IP.

Then run

> terraform apply

The terraform will output the rebond public IP, the apache public IP to access the demo site, and the ElasticSearch  nodes private IP.


Access the front instance and the ES instances from the rebond instance with root user

> root@rebond# ssh -l centos private_ip_of_instance
