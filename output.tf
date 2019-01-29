output "rebond_public_ip" {
  value = "${openstack_networking_floatingip_v2.rebond.address}"
}

output "front1_public_ip" {
  value = "${openstack_networking_floatingip_v2.front1.address}"
}

output "front1_private_ip" {
  value = "${openstack_compute_instance_v2.front1.access_ip_v4}"
}

output "es1_private_ip" {
  value = "${openstack_compute_instance_v2.es1.access_ip_v4}"
}

output "es2_private_ip" {
  value = "${openstack_compute_instance_v2.es2.access_ip_v4}"
}

output "es3_private_ip" {
  value = "${openstack_compute_instance_v2.es3.access_ip_v4}"
}
