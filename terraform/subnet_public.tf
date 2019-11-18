resource "aws_subnet" "public-101digital-us-east-1a" {
    vpc_id = "${aws_vpc.101digital.id}"
    cidr_block = "10.0.11.0/24"
    availability_zone = "us-east-1a"
    tags {
        Name = "Public-101digital-us-east-1a"
    }
}

resource "aws_subnet" "public-101digital-us-east-1b" {
    vpc_id = "${aws_vpc.101digital.id}"
    cidr_block = "10.0.12.0/24"
    availability_zone = "us-east-1b"
    tags {
        Name = "Public-101digital-us-east-1b"
    }
}
