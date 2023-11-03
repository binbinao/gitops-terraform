terraform {
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.77.8"
    }
  }
  backend "cos" {
    region = "ap-guangzhou"
    bucket = "keep-gitops-dev-1309118522"
    prefix = "terraform/state"
  }
}

provider "tencentcloud" {
  secret_id="AKIDPipvuiPuAD6mDSn25XwqjXKwSwrlbgv4"
  secret_key="2yreZL4thN79RbnwNdr6E9TJ7ylSNFGL"
  region = "ap-guangzhou"
}
