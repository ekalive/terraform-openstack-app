provider "openstack" {
  tenant_name = var.tenant_name
}

locals {
  base_name = "${var.app_name}-${var.app_environment}"
}
