# Creating route table Private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
}

# Creating 2 routes for each private subnets
resource "aws_route" "private_to_NAT" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.all_ipv4
  nat_gateway_id         = aws_nat_gateway.NAT_in_Public_Subnets.id
}

# Associating each route for to each of the private subnets
resource "aws_route_table_association" "Private" {
  count          = length(var.private_subnets_ipv4_cidr)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}

#Creating route table for Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
}

# Creating 2 routes for each public subnets
resource "aws_route" "public_to_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = var.all_ipv4
  gateway_id             = aws_internet_gateway.IGW.id
}

# Associating each route for to each of the public subnets
resource "aws_route_table_association" "Public" {
  route_table_id = aws_route_table.public.id
  count          = length(var.public_subnets_ipv4_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
}