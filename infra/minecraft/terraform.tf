terraform {
  backend "s3" {
    bucket         = "terraform-states-minecraft-example-com"
    key            = "minecraft-example-com/terraform.tfstate"
    dynamodb_table = "state-locking"
    region         = "ap-south-1"
  }
}