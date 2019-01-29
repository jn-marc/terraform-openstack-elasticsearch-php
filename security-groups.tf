/*###############################################################################
 ADMIN SECURITY GROUP
###############################################################################*/

resource "openstack_networking_secgroup_v2" "admin" {
  name                 = "admin"
  delete_default_rules = true
  description          = "Rules for and admin"
}

resource "openstack_networking_secgroup_rule_v2" "admin-ssh-jn" {
  count             = "${length(var.whitelist_ips)}"
  security_group_id = "${openstack_networking_secgroup_v2.admin.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_ip_prefix  = "${element(var.whitelist_ips,  count.index)}"
}

resource "openstack_networking_secgroup_rule_v2" "admin-ssh-self" {
  security_group_id = "${openstack_networking_secgroup_v2.admin.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.admin.id}"
}

resource "openstack_networking_secgroup_rule_v2" "admin-out-tcp" {
  security_group_id = "${openstack_networking_secgroup_v2.admin.id}"
  direction         = "egress"
  ethertype         = "IPv4"
  port_range_min    = 1
  port_range_max    = 65535
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "admin-out-udp" {
  security_group_id = "${openstack_networking_secgroup_v2.admin.id}"
  direction         = "egress"
  ethertype         = "IPv4"
  port_range_min    = 1
  port_range_max    = 65535
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
}

/*###############################################################################
 WEB SECURITY GROUP
###############################################################################*/
resource "openstack_networking_secgroup_v2" "front" {
  name                 = "front"
  delete_default_rules = true
  description          = "Rules for public web access"
}

resource "openstack_networking_secgroup_rule_v2" "web-http" {
  security_group_id = "${openstack_networking_secgroup_v2.front.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "web-https" {
  security_group_id = "${openstack_networking_secgroup_v2.front.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}

/*###############################################################################
 ES SECURITY GROUP
###############################################################################*/
resource "openstack_networking_secgroup_v2" "es" {
  name                 = "es"
  delete_default_rules = true
  description          = "Rules for elasticsearch access"
}

resource "openstack_networking_secgroup_rule_v2" "front-9200" {
  security_group_id = "${openstack_networking_secgroup_v2.es.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 9200
  port_range_max    = 9200
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.front.id}"
}

resource "openstack_networking_secgroup_rule_v2" "front-9300" {
  security_group_id = "${openstack_networking_secgroup_v2.es.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 9300
  port_range_max    = 9300
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.front.id}"
}

resource "openstack_networking_secgroup_rule_v2" "self-9200" {
  security_group_id = "${openstack_networking_secgroup_v2.es.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 9200
  port_range_max    = 9200
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.es.id}"
}

resource "openstack_networking_secgroup_rule_v2" "self-9300" {
  security_group_id = "${openstack_networking_secgroup_v2.es.id}"
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_min    = 9300
  port_range_max    = 9300
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.es.id}"
}
