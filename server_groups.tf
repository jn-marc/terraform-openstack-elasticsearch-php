resource "openstack_compute_servergroup_v2" "front_anti_affinity" {
  name     = "front_anti_affinity"
  policies = ["anti-affinity"]
}

resource "openstack_compute_servergroup_v2" "es_anti_affinity" {
  name     = "es_anti_affinity"
  policies = ["anti-affinity"]
}
