terraform {
  backend "s3" {
    bucket  = "terraform-nishikawa"
    key     = "ecs"
    region  = "ap-northeast-1"
    profile = "akarin"
  }
}
