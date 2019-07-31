resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "open ssh port for bastion"

  vpc_id = "${aws_vpc.dev.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
      Name = "user21_bastion"
  }
  
}

resource "aws_launch_configuration" "bastion_alc" {
  associate_public_ip_address = true
  image_id                    = "${var.amazon_linux}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${aws_default_security_group.dev_default.id}"]
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  desired_capacity     = "3"
  launch_configuration = "${aws_launch_configuration.bastion_alc.id}"
  max_size             = "5"
  min_size             = "1"
  name                 = "user21_bastion-asg"
  vpc_zone_identifier  = ["${aws_subnet.subnet_1a.id}"]
}