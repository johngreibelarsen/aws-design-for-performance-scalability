# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "eu-west-2"  // London
}

resource "aws_vpc" "udacity-vpc-1" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "udacity-vpc-1"
    }
}

# Private subnet
resource "aws_subnet" "udacity-subnet-private-1" {
    vpc_id = "${aws_vpc.udacity-vpc-1.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false" //it makes this a private subnet
    availability_zone = "eu-west-2a"
    tags = {
        Name = "udacity-subnet-private-1"
    }
}

# Public subnet
resource "aws_subnet" "udacity-subnet-public-1" {
    vpc_id = "${aws_vpc.udacity-vpc-1.id}"
    cidr_block = "10.0.200.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-west-2a"
    tags = {
        Name = "udacity-subnet-public-1"
    }
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

# TODO: provision 2 m4.large EC2 instances named Udacity M4
