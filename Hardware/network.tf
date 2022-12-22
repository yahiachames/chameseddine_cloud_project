resource "scaleway_vpc_private_network" "chameseddine_pnc" {
  name = "chameseddine_pn"
   project_id = var.project_id

}
resource "scaleway_vpc_public_gateway" "chameseddine_gateway" {
  name = "chameseddine_gateway"
  type = "VPC-GW-S"
  ip_id = scaleway_vpc_public_gateway_ip.gw01.id
   project_id = var.project_id
}
resource "scaleway_vpc_public_gateway_ip" "gw01" {
    project_id = var.project_id
}

resource "scaleway_vpc_public_gateway_dhcp" "dhcp01" {
  subnet = "192.168.1.0/24"
  push_default_route = true
  project_id = var.project_id
 
}
resource "scaleway_vpc_gateway_network" "main" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_network_id = scaleway_vpc_private_network.chameseddine_pnc.id
  dhcp_id = scaleway_vpc_public_gateway_dhcp.dhcp01.id
  cleanup_dhcp       = true
  enable_masquerade  = true
}


# forwarding rules

resource "scaleway_vpc_public_gateway_pat_rule" "ssh_django_server" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 22
  public_port = 2221
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}
resource "scaleway_vpc_public_gateway_pat_rule" "ssh_phpmyadmin" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 22
  public_port = 2222
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}
resource "scaleway_vpc_public_gateway_pat_rule" "ssh_frontend_react" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 22
  public_port = 2223
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}
resource "scaleway_vpc_public_gateway_pat_rule" "ui" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 80
  public_port = 3333
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}
resource "scaleway_vpc_public_gateway_pat_rule" "phpmyadmin" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 8080
  public_port = 8080
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}
resource "scaleway_vpc_public_gateway_pat_rule" "ecommerce_react_frontend" {
  gateway_id = scaleway_vpc_public_gateway.chameseddine_gateway.id
  private_ip = scaleway_vpc_public_gateway_dhcp.dhcp01.address
  private_port = 80
  public_port = 3000
  protocol = "both"
  depends_on = [scaleway_vpc_gateway_network.main, scaleway_vpc_private_network.chameseddine_pnc]
}