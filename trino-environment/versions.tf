terraform {

  required_version = ">= 1.2.0"

  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "0.6.6"
    }

    random = {
      source = "hashicorp/random"
      version = "3.7.1"
    }
  }
  
}
