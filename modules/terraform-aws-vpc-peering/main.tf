resource "aws_vpc_peering_connection" "foo" {
#   peer_owner_id = var.peer_owner_id

  peer_vpc_id   = var.vpcA_id
  vpc_id        = var.vpcC_id
  peer_region   = "us-east-1"
  # auto_accept   = true
  tags = {
    Name = "VPC Peering between vpcA and vpcC"
  }
  
}
resource "aws_vpc_peering_connection_accepter" "accept" {
  vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  auto_accept               = true
  tags = {
    Name = "VPC Peering Accepter for vpcA and vpcC"
  }
}
# resource "aws_vpc" "foo" {
#   provider   = aws.us-west-2
#   cidr_block = "10.1.0.0/16"
# }

# resource "aws_vpc" "bar" {
#   provider   = aws.us-east-1
#   cidr_block = "10.2.0.0/16"
# }