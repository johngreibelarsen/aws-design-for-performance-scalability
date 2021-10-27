# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = "AKIARJFQ6YL76YIAJQIZ"
  secret_key = "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"
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
resource "aws_launch_template" "webserver" {
  image_id = "ami-0dbec48abfe298cab"
  instance_type = "t2.micro"
  tag_specifications {
      resource_type = "instance"
      tags = {
          Name = "Udacity T2"
      }
  }
}

resource "aws_autoscaling_group" "asg-webserver" {
  desired_capacity   = 4
  max_size           = 16
  min_size           = 4
  vpc_zone_identifier = [aws_subnet.udacity-subnet-public-1.id]

  launch_template {
    id      = aws_launch_template.webserver.id
    version = "$Latest"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_launch_template" "appserver" {
  image_id = "ami-0dbec48abfe298cab"
  instance_type = "m4.large"
  tag_specifications {
      resource_type = "instance"
      tags = {
          Name = "Udacity M4"
      }
  }
}

resource "aws_autoscaling_group" "asg-appserver" {
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  vpc_zone_identifier = [aws_subnet.udacity-subnet-private-1.id]

  launch_template {
    id      = aws_launch_template.appserver.id
    version = "$Latest"
  }
}