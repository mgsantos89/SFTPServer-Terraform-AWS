terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }

  backend "s3" {
    bucket = "NOME_DO_SEU_BUCKET"
    key    = "./sftpserver"
    region = "REGIAO_DO_SEU_BUCKET"
  }
}

provider "aws" {
  region = var.region
}