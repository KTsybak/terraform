resource "aws_instance" "ec2_example" {
    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    instance_type = "${var.instance_type}"
    key_name= aws_key_pair.keys.key_name 
    vpc_security_group_ids = [aws_security_group.ec2_group.id]
    subnet_id = "${var.subnet_prv1}"
}

resource "aws_security_group" "ec2_group" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${var.myvpc}"
  
  # Allow SSH inbound for allowed IP addressess
 # ingress {
 #   from_port   = 22
 #   to_port     = 22
 #   protocol    = "tcp"
 #   cidr_blocks = ["0.0.0.0/0"]
 # }

  # TCP port 80 for HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TCP port 443 for HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound HTTP to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
resource "aws_key_pair" "keys" {
  key_name   = "aws_key"
  public_key = "${file("/home/kristina/.ssh/terraform.pub")}"
}

