variable "amazon_linux" {
  # Amazon Linux AMI 2017.03.1 (HVM), SSD Volume Type - ami-00a5245b4816c38e6 
  default = "ami-00a5245b4816c38e6"
}

variable "dev_keyname" {
  default = "user21"
}

variable "instance_type" {
  default = "t2.micro"
}
