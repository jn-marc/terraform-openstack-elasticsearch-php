resource "openstack_networking_floatingip_v2" "rebond" {
  pool = "${var.floating-ip-pool}"
}

resource "openstack_networking_floatingip_v2" "front1" {
  pool = "${var.floating-ip-pool}"
}
