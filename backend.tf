provider "aws" {
  region = var.region
  # assume_role {
  #  role_arn = ""
  #}
  default_tags {
    tags = {
      DefaultTag = "${var.project_name}"
    }
  }
}
