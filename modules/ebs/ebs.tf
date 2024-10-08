resource "aws_ebs_volume" "ebs" {
  availability_zone = var.region
  size = var.size 

  tags = {
    Name = "${var.prefixo_projeto}"
  }

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = var.instance-id
}