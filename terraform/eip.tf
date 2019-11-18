resource "aws_eip" "101digital-nat-101digital" {
  vpc      = true
}
#resource "aws_eip" "101digital-nat-101digital-b" {
#  vpc      = true
#}

resource "aws_eip" "public-k8s" {
  vpc = true

  instance                  = "${aws_instance.public-k8s.id}"
  depends_on                = ["aws_internet_gateway.101digital"]
}
