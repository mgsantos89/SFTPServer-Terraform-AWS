#!/bin/bash
# Atualizar pacotes
apt-get update -y

# Instalar o OpenSSH Server
apt-get install -y openssh-server

# Criar o usuário SFTP sem shell de login
useradd -m -s /usr/sbin/nologin sftpuser

# Criar o diretório .ssh para o usuário SFTP
mkdir -p /home/sftpuser/.ssh
chmod 700 /home/sftpuser/.ssh
chown sftpuser:sftpuser /home/sftpuser/.ssh

# Adicionar a chave pública ao arquivo authorized_key
# COLAR A CHAVE NA LINHA ABAIXO NO LOCAL INDICADO.
echo "SUA_CHAVE_VAI_AQUI" > /home/sftpuser/.ssh/authorized_keys 
chmod 600 /home/sftpuser/.ssh/authorized_keys
chown sftpuser:sftpuser /home/sftpuser/.ssh/authorized_keys

# Criar diretórios para SFTP
mkdir -p /home/sftpuser/uploads
chown root:root /home/sftpuser
chmod 755 /home/sftpuser
chown sftpuser:sftpuser /home/sftpuser/uploads

# Configurar o serviço SSH para SFTP e apenas chave pública
echo "Match User sftpuser" >> /etc/ssh/sshd_config
echo "  ForceCommand internal-sftp" >> /etc/ssh/sshd_config
echo "  PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "  PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "  AuthorizedKeysFile /home/sftpuser/.ssh/authorized_keys" >> /etc/ssh/sshd_config
echo "  ChrootDirectory /home/sftpuser" >> /etc/ssh/sshd_config
echo "  PermitTunnel no" >> /etc/ssh/sshd_config
echo "  AllowAgentForwarding no" >> /etc/ssh/sshd_config
echo "  AllowTcpForwarding no" >> /etc/ssh/sshd_config
echo "  X11Forwarding no" >> /etc/ssh/sshd_config

# Reiniciar o serviço SSH para aplicar as configurações
systemctl restart ssh
