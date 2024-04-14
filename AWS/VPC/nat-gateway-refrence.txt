# Allocate Elastic IP Address (EIP 1)
# terraform aws allocate elastic ip
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc    = 

  tags   = {
    Name = 
  }
}

# Allocate Elastic IP Address (EIP 2)
# terraform aws allocate elastic ip
resource "aws_eip" "eip-for-nat-gateway-2" {
  vpc    = 

  tags   = {
    Name =
  }
}

# Create Nat Gateway 1 in Public Subnet 1
# terraform create aws nat gateway
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = 
  subnet_id     = 

  tags   = {
    Name = 
  }
}

# Create Nat Gateway 2 in Public Subnet 2
# terraform create aws nat gateway
resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id = 
  subnet_id     = 

  tags   = {
    Name = 
  }
}

# Create Private Route Table 1 and Add Route Through Nat Gateway 1
# terraform aws create route table
resource "aws_route_table" "private-route-table-1" {
  vpc_id            = 

  route {
    cidr_block      = 
    nat_gateway_id  = 
  }

  tags   = {
    Name = 
  }
}

# Associate Private Subnet 1 with "Private Route Table 1"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id         = 
  route_table_id    = 
}

# Associate Private Subnet 3 with "Private Route Table 1"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id         = 
  route_table_id    = 
}

# Create Private Route Table 2 and Add Route Through Nat Gateway 2
# terraform aws create route table
resource "aws_route_table" "private-route-table-2" {
  vpc_id            = 

  route {
    cidr_block      = 
    nat_gateway_id  = 
  }

  tags   = {
    Name =
  }
}

# Associate Private Subnet 2 with "Private Route Table 2"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id         = 
  route_table_id    = 
}

# Associate Private Subnet 4 with "Private Route Table 2"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-4-route-table-association" {
  subnet_id         = 
  route_table_id    =
}