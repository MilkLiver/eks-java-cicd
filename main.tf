terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}


resource "helm_release" "eks-java-demo" {
  name      = "java-demo"
  namespace = "eks-java-demo"
  
  chart   = "./helmchart"
  timeout = 300
  wait    = true
  force_update = true

  values = [
    file("${path.module}/helmchart/values.yaml")
  ]

  set = [
    {
      name  = "image.tag"
      value = var.IMAGE_TAG
    }
  ]
}
