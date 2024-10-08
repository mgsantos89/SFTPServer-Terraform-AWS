variable "prefixo_projeto" {
  type        = string
  description = "Prefixo para nome de recursos"
}


variable "type" {
    type = string
    description = "Tipo de Instancia EC2"
}

variable "key_name" {
  type = string
  description = "Nome da Chave Provisionada na AWS"
}

variable "subnet_id" {
    type = string
    description = "ID da Subnet"
  
}

variable "sg-id" {
  type = string
  description = "Security Group ID"
}