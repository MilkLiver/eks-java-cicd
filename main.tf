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
  name      = "eks-java-demo"
  namespace = "eks-java-cicd"

  # 1. 指定本機路徑 (相對於 terraform 執行路徑)
  chart   = "./helmchart"
  timeout = 300
  wait    = true
  force_update = true

  values = [
    file("${path.module}/helmchart/values.yaml")
  ]

  # 4. 指定動態環境變數 (例如從 GitHub Action 傳入的 IMAGE_TAG)
  # 這邊的設定會覆蓋 values.yaml 裡面的同名數值
  set = [
    {
      name  = "image.tag"
      value = var.IMAGE_TAG # 假設你定義了 terraform variable
    }
  ]
}
