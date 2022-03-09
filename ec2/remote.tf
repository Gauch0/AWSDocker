terraform {
  backend "s3" {
      bucket = "matiasbuckettest"
      key = "LinuxMatias/terraform.state"
      region = "us-east-1"
  }
}

data "terraform_remote_state" "matiasvpc" {
    backend = "s3"
    config = {
        bucket = "matiasbuckettest"
        key = "vpc/terraform.state"
        region = "us-east-1"
    }
}