resource "aws_subnet" "private-101digital-us-east-1a" {
    vpc_id = "${aws_vpc.101digital.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags {
        Name = "Private-101digital-us-east-1a"
    }
}

resource "aws_subnet" "private-101digital-us-east-1b" {
    vpc_id = "${aws_vpc.101digital.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags {
        Name = "Private-101digital-us-east-1b"
    }
}
