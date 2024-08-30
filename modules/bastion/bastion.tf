resource "aws_instance" "bastion_host" {
  ami           = "ami-015875403620174eb"
  instance_type = "t2.micro"
  key_name      = var.ssh_key
  subnet_id     = data.aws_subnet.public-a.id

  tags = {
    Name = var.bastion_host_name
  }

  # security_groups = [
  #   aws_security_group.bastion_host_sg.id
  # ]
  
  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
}

