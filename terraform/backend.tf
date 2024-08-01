terraform {
  backend "s3" {
    bucket  = "terraform-infra"
    region  = "eu-central-1"
    key     = "eu-central-1/terraform.tfstate"
    encrypt = "true"
  }
}
