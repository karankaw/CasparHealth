terraform {
  required_version = "1.4.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.63" #Always mention the versions to eliminate version mismatch integration issues later
    }
  }

  backend "local" {}
}

#Plugin for AWS
provider "aws" {
  region = var.region
}
