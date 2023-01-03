resource "scaleway_vpc_private_network" "chameseddine_pnc" {
  name       = "chameseddinepn"
  project_id = var.project_id

}
# resource "scaleway_vpc_public_gateway" "chameseddine_gateway" {
#   name            = "chameseddine_gateway"
#   type            = "VPC-GW-S"
#   ip_id           = scaleway_vpc_public_gateway_ip.gw01.id
#   project_id      = var.project_id
#   bastion_enabled = true
# }
# resource "scaleway_vpc_public_gateway_ip" "gw01" {
#   project_id = var.project_id
# }

# resource "scaleway_vpc_public_gateway_dhcp" "dhcp01" {
#   subnet             = "10.42.42.0/24"
#   push_default_route = true
#   project_id         = var.project_id
#   pool_low           = "10.42.42.100"
#   pool_high          = "10.42.42.200"
#   dns_local_name     = scaleway_vpc_private_network.chameseddine_pnc.name


# }


# resource "scaleway_vpc_gateway_network" "main" {
#   gateway_id         = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_network_id = scaleway_vpc_private_network.chameseddine_pnc.id
#   dhcp_id            = scaleway_vpc_public_gateway_dhcp.dhcp01.id
#   enable_dhcp        = true
# }


# # forwarding rules

# resource "scaleway_vpc_public_gateway_pat_rule" "ssh_django_server" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.11"
#   private_port = 22
#   public_port  = 2221
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "ssh_phpmyadmin" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.12"
#   private_port = 22
#   public_port  = 2222
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "ssh_frontend_react" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.13"
#   private_port = 22
#   public_port  = 2223
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "ui" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.11"
#   private_port = 80
#   public_port  = 3333
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "phpmyadmin" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.12"
#   private_port = 8080
#   public_port  = 8080
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
# resource "scaleway_vpc_public_gateway_pat_rule" "ecommerce_react_frontend" {
#   gateway_id   = scaleway_vpc_public_gateway.chameseddine_gateway.id
#   private_ip   = "10.42.42.13"
#   private_port = 80
#   public_port  = 3000
#   protocol     = "both"
#   depends_on   = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
# }
output "public_ip" {
  value = scaleway_instance_ip.public_ip
}
