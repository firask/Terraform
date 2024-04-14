variable "ami" {
  type        = string
  description = "Amazon Image"
  default   = "ami-08e4e35cccc6189f4"
}

variable "instance_type" {
  type = string
  description = "AWS instance type"
  default = "t2.micro"
}

variable "vpc_cidr" {
  type = string
  description = "VPC CIDR Block"
  default = "10.0.0.0/16"

}

variable "subnet-1" {
  type = string
  description = "Subnet-1 CIDR"
  default = "10.0.1.0/24"
}