variable "region"{
    type = string
    description = "Região onde será provisionado o volume"
}

variable "size"{
    type = number
    description = "Tamanho do Volume"
}

variable "prefixo_projeto" {
  type = string
  description = "Prefixo do Projeto"
}

variable "instance-id" {
  type = string
  description = "ID da Instancia"
}