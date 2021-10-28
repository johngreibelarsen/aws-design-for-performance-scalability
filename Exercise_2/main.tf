provider "aws" {
  region = "${var.AWS_REGION}"  // London
}

resource "aws_vpc" "udacity-vpc-2" {
    cidr_block = "10.2.0.0/16"

    tags = {
        Name = "udacity-vpc-2"
    }
}

# Public subnet
resource "aws_subnet" "udacity-subnet-public-2" {
    vpc_id = "${aws_vpc.udacity-vpc-2.id}"
    cidr_block = "10.2.200.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "${var.AWS_AZ}"
    tags = {
        Name = "udacity-subnet-public-2"
    }
}

