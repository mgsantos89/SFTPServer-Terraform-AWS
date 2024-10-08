resource "aws_eip" "lb" {
  instance = var.instanceID
  domain   = "vpc"
    tags = {
    Name = "${var.prefixo_projeto}-EIP"
  }
}