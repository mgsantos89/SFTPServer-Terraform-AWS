module "SFTP-Security-Group"{
  source = "./modules/securitygroup"
  vpc_id = var.vpc_id
  prefixo_projeto = var.prefixo_projeto
}

module "SFTP-Server" {
  source = "./modules/ec2"
  type = var.type
  key_name = var.key_name
  subnet_id = var.subnet_id
  prefixo_projeto = var.prefixo_projeto
  sg-id = module.SFTP-Security-Group.sg-id

}

module "ip" {
    source = "./modules/eip"
    instanceID = module.SFTP-Server.instanceID
    prefixo_projeto = var.prefixo_projeto
}