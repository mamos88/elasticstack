provider "aws" {
  profile = var.profile
  region     = var.aws_region
}

# terraform {
#   required_providers {
#     random = {
#       source = "hashicorp/random"
#       version = "3.5.1"
#     }
#   }
# }