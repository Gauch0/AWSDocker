terraform {
  backend "s3" {
      bucket = "matiasbuckettest"
      key = "LinuxMatias/terraform.state"
      region = "us-east-1"
  }
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "matiasbuckettest"
        key = "matiasvpc/terraform.state"
        region = "us-east-1"
    }
}