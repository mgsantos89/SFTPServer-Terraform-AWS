# Terraform AWS SFTP Server 
Este repositório contém configurações do Terraform para provisionar um servidor SFTP na AWS usando EC2. A solução utiliza uma instância EC2 com armazenamento anexado para SFTP e um grupo de segurança para gerenciar o acesso.

## Prerequisitos

Antes de começar, certifique-se de que você possui o seguinte:

- Uma conta AWS
- Bucket S3 para Backend do Terraform.
- Terraform instalado ([Guia de instalação](https://learn.hashicorp.com/tutorials/terraform/install-cli))
- AWS CLI configurado com as credenciais apropriadas ([Guia de configuração do AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html))
- Par de chaves já provisionado na AWS.


## Funcionalidades

- Provisionamento de uma instância EC2 para acesso SFTP
- Elastic IP atachado a instância
- Configuração de regras de grupo de segurança para acesso seguro (portas SSH e SFTP)
- Configuração automática de acesso via par de chaves


## Uso

### Passo 1: Clone o repositório

```bash
git clone https://github.com/mgsantos89/SFTPServer-Terraform-AWS.git
```

### Passo 2: Configurando o Backend no S3

Este projeto usa um bucket S3 para armazenar remotamente o arquivo de estado do Terraform, permitindo que o estado seja compartilhado e gerenciado com segurança. Para configurar o backend S3 no arquivo `providers.tf`, adicione a configuração do backend S3, especificando o bucket, a região e a chave (o nome do arquivo de estado) que será armazenado no bucket S3.

```hcl
terraform {
  backend "s3" {
    bucket         = "meu-bucket-terraform-state"
    key            = "sftp/terraform.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}
```

- `bucket`: O nome do bucket S3 onde o estado será armazenado.
- `key`: O caminho dentro do bucket onde o arquivo de estado será salvo (por exemplo, `sftp/terraform.tfstate`).
- `region`: A região onde o bucket S3 está localizado.


### Passo 3: Modifique as Variáveis

Crie seu `terraform.tfvars` para personalizar os seguintes parâmetros de acordo com suas necessidades:

- `type`: Especifique o tipo de instância EC2 (padrão: `t2.micro`)
- `key_name`: Seu par de chaves ja provisionado na AWS.
- `region`: Região AWS para provisionar o servidor
- `vpc_id`: ID da sua VPC na pre-existente na AWS
- `subnet_id` = ID da subnet existente na VPC
- `prefixo_projeto`= Nome que julgar pro projeto ex: SFTP Server


### Passo 4: Gerar o Par de Chaves SSH (localmente para acesso o SFTP)

Gerar um par de chaves SSH no computador local com o seguinte comando 

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/sftp_key
```

Esse comando gera um par de chaves chamado `sftp_key` (chave privada) e `sftp_key.pub` (chave pública).

- **Chave privada (`sftp_key`)**: deve ser mantida no cliente, pois será usada para autenticação.
- **Chave pública (`sftp_key.pub`)**: será copiada para o servidor SFTP.

### 5. **Ajustar o Script do Servidor SFTP para Autenticação por Chave**

O script **User Data** no Terraform precisa ser modificado para adicionar a **chave pública SSH** ao servidor, permitindo a autenticação do cliente.

Aqui está como você pode ajustar o seu script `sftp_setup.sh` que fica no caminho `modules/ec2/`, substituir a chave de exemplo no local indicado pela chave publica gerada no passo anterior.

----------------
### Passo 6: Inicialize e aplique o Terraform

```bash
# Inicializar o Terraform
terraform init

# Validar a configuração
terraform validate

# Planejar o provisionamento
terraform plan

# Aplicar a configuração
terraform apply
```

### Passo 7: Teste a conectividade via SSH/SFTP

#### Teste via SSH
No terminal (onde você tem a **chave privada**):

```bash
ssh -i /caminho/para/sua-chave-privada.pem sftpuser@IP-ou-DNS-da-instancia
```

- Substitua `/caminho/para/sua-chave-privada.pem` pela localização da chave privada que corresponde à chave pública no servidor.
- Substitua `IP-ou-DNS-da-instancia` pelo IP ou DNS público da sua instância.

#### Teste via SFTP
Você também pode testar diretamente a conectividade via **SFTP**:

```bash
sftp -i /caminho/para/sua-chave-privada.pem sftpuser@IP-ou-DNS-da-instancia
```

Se tudo estiver configurado corretamente, você deve se conectar sem precisar fornecer uma senha, utilizando a chave privada.

## Limpeza

Para destruir a infraestrutura e limpar os recursos na AWS:

```bash
terraform destroy
```

## Considerações de Segurança

- Certifique-se de que seu par de chaves SSH seja mantido seguro e não seja compartilhado.
- Use políticas IAM fortes para restringir o acesso apenas aos usuários necessários.
- Configure logs e monitoramento adequados para a atividade SFTP via AWS CloudWatch (opcional).

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
