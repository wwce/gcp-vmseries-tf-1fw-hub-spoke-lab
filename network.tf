# --------------------------------------------------------------------------------------------------------------------------
# Create firewall VPCs & subnets

module "vpc_mgmt" {
  source               = "./modules/vpc/"
  vpc                  = "${local.prefix}-mgmt-vpc"
  delete_default_route = false
  allowed_sources      = var.mgmt_sources
  allowed_protocol     = "TCP"
  allowed_ports        = ["443", "22"]

  subnets = {
    "mgmt-${var.region}" = {
      region = var.region,
      cidr   = var.cidrs_mgmt[0]
    }
  }
}

module "vpc_untrust" {
  source               = "./modules/vpc/"
  vpc                  = "${local.prefix}-untrust-vpc"
  delete_default_route = false
  allowed_sources      = ["0.0.0.0/0"]

  subnets = {
    "untrust-${var.region}" = {
      region = var.region,
      cidr   = var.cidrs_untrust[0]
    }
  }
}

module "vpc_trust" {
  source               = "./modules/vpc/"
  vpc                  = "${local.prefix}-trust-vpc"
  delete_default_route = true
  allowed_sources      = ["0.0.0.0/0"]

  subnets = {
    "trust-${var.region}" = {
      region = var.region,
      cidr   = var.cidrs_trust[0]
    }
  }
}


