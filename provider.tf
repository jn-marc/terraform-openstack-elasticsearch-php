provider "openstack" {
  user_name   = "${var.openstack_username}"
  tenant_name = "${var.openstack_project}"
  domain_name = "default"
  password    = "${var.openstack_password}"
  auth_url    = "${var.openstack_auth_url}"
  region      = "regionOne"
}
