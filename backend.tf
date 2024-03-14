provider "aws" {
  region = var.region

  default_tags {
    tags = {
      DefaultTag = "${var.project_name}"
    }
  }
}