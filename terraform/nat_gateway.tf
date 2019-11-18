resource "aws_nat_gateway" "101digital-101digital" {
    allocation_id = "${aws_eip.101digital-nat-101digital.id}"
    subnet_id = "${aws_subnet.public-101digital-us-east-1a.id}"
}
#resource "aws_nat_gateway" "101digital-101digital-b" {
#    allocation_id = "${aws_eip.101digital-nat-101digital-b.id}"
#    subnet_id = "${aws_subnet.private-101digital-us-east-1b.id}"
#}
