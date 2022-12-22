
resource "scaleway_instance_server" "server_chameseddine" {
  image = "debian_bullseye"
  type  = "DEV1-S"
  zone = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name="chameseddine_backend_server"
    private_network {
        pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
    }
}

resource "scaleway_instance_server" "server_phpmyadmin_chameseddine" {
  image = "debian_bullseye"
  type  = "DEV1-S"
  zone = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name="chameseddine_phpmyadmin"
    private_network {
        pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
    }
}
resource "scaleway_instance_server" "ecommerce_frontend_react_chameseddine" {
  image = "debian_bullseye"
  type  = "DEV1-S"
  zone = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name="ecommerce_frontend_react_chameseddine"
    private_network {
        pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
    }
}

resource "scaleway_rdb_instance" "main" {
  project_id = var.project_id
  name              = "chameseddine_db"
  node_type         = "db-dev-s"
  engine            = "MySQL-8"
  is_ha_cluster     = false
  disable_backup    = true
  user_name         = "admin"
  password          = "#Chameseddine14"
  region            = "fr-par"
  tags              = ["terraform-test", "scaleway_rdb_instance", "volume", "rdb_pn"]
  volume_type       = "bssd"
  volume_size_in_gb = 10
  private_network {
    ip_net = "192.168.1.254/24" 
    pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
  }
}

resource "scaleway_rdb_database" "main" {
  instance_id    = scaleway_rdb_instance.main.id
  name           = "ecommerce"
}








