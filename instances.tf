data "openstack_compute_flavor_v2" "server_size" {
  name = var.server_size
}

data "openstack_images_image_v2" "server_image" {
  name        = var.server_image
  most_recent = true
}

resource "openstack_compute_keypair_v2" "app_keypair" {
  name = "${local.base_name}-keypair"
}

resource "openstack_compute_instance_v2" "app_server" {
  count           = var.number_of_servers
  name            = format("${local.base_name}-%02d", count.index + 1)
  image_id        = data.openstack_images_image_v2.server_image.id
  flavor_id       = data.openstack_compute_flavor_v2.server_size.id
  key_pair        = openstack_compute_keypair_v2.app_keypair.name
  security_groups = [ openstack_networking_secgroup_v2.app_secgroup.name ]

  network {
    name = var.app_network
  }

  depends_on =[
    var.subnet_resource
  ]

}

resource "openstack_compute_floatingip_v2" "public" {
  count     = var.number_of_servers
  pool      = var.ext_net_name
}

resource "openstack_compute_floatingip_associate_v2" "public" {
  count       = var.number_of_servers
  floating_ip = openstack_compute_floatingip_v2.public[count.index].address
  instance_id = openstack_compute_instance_v2.app_server[count.index].id
}