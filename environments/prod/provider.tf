terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.77.8"
    }
  }
  backend "cos" {
    region = "ap-guangzhou"
    bucket = "keep-gitops-prod-1309118522"
    prefix = "terraform/state"
  }
}

provider "tencentcloud" {
  region = "ap-guangzhou"
}
