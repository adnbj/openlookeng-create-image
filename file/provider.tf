terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.28.0"
    }
  }
}

# Configure the HuaweiCloud Provider
provider "huaweicloud" {
  region      = "cn-south-1"
  access_key  = var.ak
  secret_key  = var.sk
}
