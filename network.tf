resource "openstack_networking_network_v2" "private_network" {
  name           = "demo_private_net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = "demo_private_subnet"
  network_id      = "${openstack_networking_network_v2.private_network.id}"
  cidr            = "10.0.0.0/24"
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "r1" {
  name                = "demo_r1"
  external_network_id = "2874d8af-4d72-4216-981d-56acf7459397"
  admin_state_up      = true
}

resource "openstack_networking_router_interface_v2" "r1-interface" {
  router_id = "${openstack_networking_router_v2.r1.id}"
  subnet_id = "${openstack_networking_subnet_v2.private_subnet.id}"
}
