resource "openstack_compute_instance_v2" "front1" {
  name              = "front1"
  image_name        = "Centos-7.5"
  flavor_name       = "exp1.M"
  key_pair          = "${openstack_compute_keypair_v2.rebond.name}"
  security_groups   = ["admin", "front"]
  availability_zone = "mar02"

  depends_on = ["openstack_networking_subnet_v2.private_subnet"]

  user_data = "${ data.template_cloudinit_config.front.rendered }"

  scheduler_hints {
    group = "${openstack_compute_servergroup_v2.front_anti_affinity.id}"
  }

  metadata {
    groups = "front-servers"
  }

  network {
    uuid = "${openstack_networking_network_v2.private_network.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "front1" {
  floating_ip = "${openstack_networking_floatingip_v2.front1.address}"
  instance_id = "${openstack_compute_instance_v2.front1.id}"
}
