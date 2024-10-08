resource "aws_security_group" "SFTP-SG" {
  name        = "SFTP-SG"
  description = "Allow SFTP and SSH Rules"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefixo_projeto}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_22_port" {
  security_group_id = aws_security_group.SFTP-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.SFTP-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}