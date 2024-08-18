resource "aws_security_group" "bastion_host_sg" {
  vpc_id = data.aws_vpc.vpc.id
  name        = "${var.bastion_host_name}-sg"
  description = "Allow SSH communication to bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}