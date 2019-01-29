resource "openstack_compute_instance_v2" "rebond" {
  name              = "rebond"
  image_name        = "Centos-7.5"
  flavor_name       = "exp1.M"
  key_pair          = "${openstack_compute_keypair_v2.local.name}"
  security_groups   = ["admin"]
  availability_zone = "mar02"

  depends_on = ["openstack_networking_subnet_v2.private_subnet"]

  user_data = "${ data.template_cloudinit_config.rebond.rendered }"

  network {
    uuid = "${openstack_networking_network_v2.private_network.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "rebond" {
  floating_ip = "${openstack_networking_floatingip_v2.rebond.address}"
  instance_id = "${openstack_compute_instance_v2.rebond.id}"
}
