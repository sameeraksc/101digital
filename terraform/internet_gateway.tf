resource "aws_internet_gateway" "101digital" {
    vpc_id = "${aws_vpc.101digital.id}"
    tags {
        Name = "101digital"
    }
}
