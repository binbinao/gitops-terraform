# 自动补全代码

data "tencentcloud_availability_zones" "zones" {}

resource "tencentcloud_vpc" "vpc" {
  name       = "rj-tf-example"
  cidr_block = "10.0.0.0/16"
}

resource "tencentcloud_subnet" "subnet-mgmt" {
  vpc_id            = tencentcloud_vpc.vpc.id
  name              = "subnet-mgmt"
  cidr_block        = "10.0.0.0/24"
  availability_zone = data.tencentcloud_availability_zones.zones.zones.0.name
  is_multicast      = false
}

resource "tencentcloud_subnet" "subnet-compute" {
  vpc_id            = tencentcloud_vpc.vpc.id
  name              = "subnet-compute"
  cidr_block        = "10.0.3.0/24"
  availability_zone = data.tencentcloud_availability_zones.zones.zones.2.name
  is_multicast      = false
}

data "tencentcloud_images" "my_favorite_image" {
  image_type       = ["PUBLIC_IMAGE"]
  image_name_regex = "Final"
}

data "tencentcloud_instance_types" "my_favorite_instance_types" {
  filter {
    name   = "instance-family"
    values = ["SA2"]
  }

  cpu_core_count   = 2
  exclude_sold_out = true
}

data "tencentcloud_availability_zones_by_product" "my_favorite_zones" {
  product = "cvm"
}

// Create a POSTPAID_BY_HOUR CVM instance
resource "tencentcloud_instance" "cvm_mgmt" {
  instance_name     = "cvm_mgmt"
  availability_zone = data.tencentcloud_availability_zones_by_product.my_favorite_zones.0.name
  image_id          = data.tencentcloud_images.my_favorite_image.images.0.image_id
  instance_type     = data.tencentcloud_instance_types.my_favorite_instance_types.instance_types.0.instance_type
  system_disk_type  = "CLOUD_PREMIUM"
  system_disk_size  = 50
  hostname          = "user"
  project_id        = 0
  vpc_id            = tencentcloud_vpc.vpc.id
  subnet_id         = tencentcloud_subnet.subnet-mgmt.id

  data_disks {
    data_disk_type = "CLOUD_PREMIUM"
    data_disk_size = 50
    encrypt        = false
  }

  tags = {
    tagKey = "tagValue"
  }
}