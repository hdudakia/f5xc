terraform {
  required_version = ">= 3.2.2"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.33.0"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}