terraform {
  required_providers {
    aws = {
      # region  = "us-west-2"
      source  = "hashicorp/aws"
      version = "~> 5.33.0"  
    }
  }

  required_version = ">= 1.3"
}
