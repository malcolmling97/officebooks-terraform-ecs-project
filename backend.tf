# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {

    bucket          = "officebooks-terraform-remote-state"
    key             = "rentzone-ecs/terraform.tfstate"
    region          = "ap-southeast-1"
    profile         = "Malcolm_ECS"
    dynamodb_table  = "officebooks-terraform-state-lock"
    
  }
}