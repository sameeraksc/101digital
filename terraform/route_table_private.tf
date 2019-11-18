/* Route Table */
resource "aws_route_table" "private-101digital" {
    vpc_id = "${aws_vpc.101digital.id}"
    tags {
        Name = "101digital-Private-101digital"
    }
}

#resource "aws_main_route_table_association" "private-101digital" {
#    vpc_id = "${aws_vpc.101digital.id}"
#    route_table_id = "${aws_route_table.private-101digital.id}"
#}

/* Route Table Subnet Association */
resource "aws_route_table_association" "private-101digital-us-east-1a" {
    subnet_id = "${aws_subnet.private-101digital-us-east-1a.id}"
    route_table_id = "${aws_route_table.private-101digital.id}"
}

resource "aws_route_table_association" "private-101digital-us-east-1b" {
    subnet_id = "${aws_subnet.private-101digital-us-east-1b.id}"
    route_table_id = "${aws_route_table.private-101digital.id}"
}

/* Routes on Route Table */
resource "aws_route" "private-101digital-default" {
    route_table_id = "${aws_route_table.private-101digital.id}"
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.101digital-101digital.id}"
    depends_on = ["aws_route_table.private-101digital"]
}

#main 101digital
resource "aws_route" "main_private_101digital_to_101digital_101digital" {
    route_table_id = "${aws_route_table.private-101digital.id}"
    destination_cidr_block = "172.31.0.0/16"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}
