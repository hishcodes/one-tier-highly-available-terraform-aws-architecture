resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "available_azs" {
  state = "available"
}

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = data.aws_availability_zones.available_azs.names[0]
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  availability_zone       = data.aws_availability_zones.available_azs.names[1]
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "pub_rt_assoc_1" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_rt_assoc_2" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.pub_rt.id
}

