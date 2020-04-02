variable "tenant_name" {
  description = "Name of the tenant to deploy the application"
}

variable "app_name" {
  description = "Brief name of the application"
}

variable "app_environment" {
  description = "Name of the environment the application is getting deployed to"
}

variable "number_of_servers" {
  default = 1
  description = "The number of servers to deploy in the tenant"
}

variable "server_size" {
  default = "m1.small"
  description = "The size of server to deploy"
}

variable "server_image" {
  default = "cirros-0.4.0-x86_64-disk"
}

variable "ext_net_name" {
  default = "public"
  description = "Name of the network to get floating IPs"
}

variable "app_network" {
  description = "Name of the network to deploy the application to"
}

variable "subnet_resource" {
  description = "The subnet resource exported from the previous module"
}