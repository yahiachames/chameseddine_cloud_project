
data "template_file" "userdata_django_backend" {
  template = file("${path.module}/cloud-init-back-django.yml")

  vars = {

    user        = "debian"
    db_ip       = "10.42.42.15"
    db_username = "admin"
    db_password = "test"
    ip_server   = "10.42.42.11"

  }
  depends_on = [
    scaleway_rdb_database.main
  ]

}


resource "scaleway_instance_server" "server_chameseddine" {
  image      = "debian_bullseye"
  type       = "DEV1-S"
  zone       = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name       = "chameseddinebackendserver"
  cloud_init = data.template_file.userdata_django_backend.rendered


  private_network {
    pn_id = scaleway_vpc_private_network.chameseddine_pnc.id

  }
}

data "template_file" "userdata_phpmyadmin" {
  template = file("${path.module}/cloud-init-phpmyadmin.yml")

  vars = {

    user  = "debian"
    db_ip = "10.42.42.15"
    instance_ip = "10.42.42.12"

  }
  # depends_on = [
  #   scaleway_rdb_database.main
  # ]

}

resource "scaleway_instance_server" "server_phpmyadmin_chameseddine" {
  image      = "debian_bullseye"
  type       = "DEV1-S"
  zone       = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name       = "chameseddinephpmyadmin"
  cloud_init = data.template_file.userdata_phpmyadmin.rendered
  private_network {
    pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
  }
 }
resource "scaleway_instance_ip" "public_ip" {
    project_id = var.project_id

}

data "template_file" "userdata_react_frontend" {
  template = file("${path.module}/cloud-init-frontend-react.yml")

  vars = {
    ip_server = "10.42.42.11"
    user        = "debian"
    db_ip       = "10.42.42.15"
    db_username = "admin"
    db_password = "test
    ip_instance = scaleway_instance_ip.public_ip.address
    private_ip = "10.42.42.13"
  }
  # depends_on = [
  #   scaleway_instance_server.server_chameseddine
  # ]

}


resource "scaleway_instance_server" "ecommerce_frontend_react_chameseddine" {
  image      = "debian_bullseye"
  type       = "DEV1-S"
  zone       = scaleway_vpc_private_network.chameseddine_pnc.zone
  project_id = var.project_id
  name       = "ecommercefrontendreactchameseddine"
  cloud_init = data.template_file.userdata_react_frontend.rendered
  private_network {
    pn_id = scaleway_vpc_private_network.chameseddine_pnc.id
  }
  ip_id = scaleway_instance_ip.public_ip.id
}

resource "scaleway_rdb_instance" "main" {
  project_id        = var.project_id
  name              = "chameseddine_db"
  node_type         = "db-dev-s"
  engine            = "MySQL-8"
  is_ha_cluster     = false
  disable_backup    = true
  user_name         = "admin"
  password          = "test"
  region            = "fr-par"
  tags              = ["terraform-test", "scaleway_rdb_instance", "volume", "rdb_pn"]
  volume_type       = "bssd"
  volume_size_in_gb = 10


  private_network {
    ip_net = "10.42.42.15/24"
    pn_id  = scaleway_vpc_private_network.chameseddine_pnc.id
  }
}

resource "scaleway_rdb_database" "main" {
  instance_id = scaleway_rdb_instance.main.id
  name        = "ecommerce"
}








