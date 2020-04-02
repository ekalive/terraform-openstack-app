resource "openstack_networking_secgroup_v2" "app_secgroup" {
  name        = "${local.base_name}-secgroup"
  description = "Security Group for App ${var.app_name}"
}

resource "openstack_networking_secgroup_rule_v2" "app_secgroup_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.app_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "app_secgroup_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.app_secgroup.id
}