variable "aws_region" {
  default = "us-east-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "polyglot-key"
}