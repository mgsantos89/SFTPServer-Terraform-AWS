variable "type" {
    type = string
    description = "Tipo de Instancia EC2"
    default = "t2.micro"
}

variable "region" {
  type        = string
  description = "Região AWS para criação dos Recursos"
}

variable "key_name" {
    type = string
    description = "Nome da Chave"
  
}

variable "subnet_id" {
    type = string
    description = "ID da Subnet"
  
}
variable "prefixo_projeto" {
  type        = string
  description = "Prefixo para nome de recursos"
}

variable "vpc_id" {
  type = string
  description = "ID da VPC"
}
