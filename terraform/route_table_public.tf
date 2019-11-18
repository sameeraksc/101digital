/* Route Table */
resource "aws_route_table" "public-101digital" {
    vpc_id = "${aws_vpc.101digital.id}"
    tags {
        Name = "101digital-Public-101digital"
    }
}
resource "aws_main_route_table_association" "public-101digital" {
    vpc_id = "${aws_vpc.101digital.id}"
    route_table_id = "${aws_route_table.public-101digital.id}"
}


/* Route Table Subnet Association */
resource "aws_route_table_association" "public-101digital-us-east-1a" {
    subnet_id = "${aws_subnet.public-101digital-us-east-1a.id}"
    route_table_id = "${aws_route_table.public-101digital.id}"
}

resource "aws_route_table_association" "public-101digital-us-east-1b" {
    subnet_id = "${aws_subnet.public-101digital-us-east-1b.id}"
    route_table_id = "${aws_route_table.public-101digital.id}"
}


/* Routes on Route Table */
resource "aws_route" "public-101digital-default" {
    route_table_id = "${aws_route_table.public-101digital.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.101digital.id}"
    depends_on = ["aws_route_table.public-101digital"]
}

#/*resource "aws_route" "public-101digital-172-31" {
#    route_table_id = "${aws_route_table.public-101digital.id}"
#    destination_cidr_block = "172.31.0.0/16"
#    vpc_peering_connection_id = "pcx-00f56269"
#    depends_on = ["aws_route_table.public-101digital"]
#}
#
#resource "aws_route" "public-101digital-12-28" {
#    route_table_id = "${aws_route_table.public-101digital.id}"
#    destination_cidr_block = "10.28.0.0/16"
#    vpc_peering_connection_id = "pcx-03f0656a"
#    depends_on = ["aws_route_table.public-101digital"]
#}
#*/
#
##main 101digital
resource "aws_route" "main_public_101digital_to_101digital_101digital" {
    route_table_id = "${aws_route_table.public-101digital.id}"
    destination_cidr_block = "172.31.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}
