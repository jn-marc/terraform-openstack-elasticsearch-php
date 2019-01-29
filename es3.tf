resource "openstack_compute_instance_v2" "es3" {
  name              = "demo_es3"
  image_name        = "Centos-7.5"
  flavor_name       = "exp1.M"
  key_pair          = "${openstack_compute_keypair_v2.rebond.name}"
  security_groups   = ["admin", "es"]
  availability_zone = "mar01"

  depends_on = ["openstack_networking_subnet_v2.private_subnet"]

  user_data = "${ data.template_cloudinit_config.es.rendered }"

  scheduler_hints {
    group = "${openstack_compute_servergroup_v2.es_anti_affinity.id}"
  }

  metadata {
    groups = "es"
  }

  network {
    uuid = "${openstack_networking_network_v2.private_network.id}"
  }
}
