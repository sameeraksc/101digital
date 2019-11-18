#resource "aws_vpc_peering_connection" "foo" {
#  peer_owner_id = "365332798508"
#  peer_vpc_id   = "vpc-2abaeb50"
#  vpc_id        = "${aws_vpc.101digital.id}"
#  auto_accept   = true
#
#  tags = {
#    Name = "VPC Peering between foo and bar"
#  }
#}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "vpc-2abaeb50"
  peer_vpc_id   = "${aws_vpc.101digital.id}"
  peer_owner_id = "365332798508"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}
