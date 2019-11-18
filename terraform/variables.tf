variable "access_key" { default = "AKIAVKD4IDQWHRYN7X6V" }
variable "secret_key" { default = "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" }
variable "region" { default = "us-east-1" }

variable "key_name" { default = "IOT" }
variable "ami" { default = "ami-02eac2c0129f6376b" }



/*variable "security_group_web" { default = "sg-137b6779" }
variable "security_group_tomcat" { default = "sg-58746832" }
variable "security_group_db" { default = "sg-497b6723" }
variable "security_group_zero" { default = "sg-4ec6d924" }

variable "subnets_public" {
  default = [
    "${aws_subnet.public-101digital-us-east-1a.id}",
    "${aws_subnet.public-101digital-us-east-1b.id}"
  ]
}

variable "subnets_private" {
  default = {
    eu-central-1a = "subnet-5281ed39"
    eu-central-1b = "subnet-5e08ac23"
  }
}

variable "elb" {
  default = {
    healthy_threshold = "2"
    unhealthy_threshold = "2"
    timeout = "3"
    interval = "5"
    idle_timeout = "180"
    connection_draining_timeout = "300"
  }
}*/
