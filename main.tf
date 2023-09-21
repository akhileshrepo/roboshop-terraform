terraform {
    backend "s3" {}
}

variable "test" {}
output "test" {
    value = var.test
}