data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type
  key_name = var.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = ["${var.sg-id}"]

  root_block_device {
    volume_size = "20"
    volume_type = "gp2"
    delete_on_termination = true
  }
  user_data = file("${path.module}/sftp_setup.sh")
  tags = {
    Name = "${var.prefixo_projeto}"
  }
}

