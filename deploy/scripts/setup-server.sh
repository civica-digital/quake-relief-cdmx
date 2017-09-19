#!/bin/bash

# The intention of this script is to setup a server with the default
# configuration, documenting (infrastructure as code) the tasks
# that we normaly use in our staging/production environments.
#
# It should be runned as root, as many commands requires root access.

username=${USERNAME}
aws_ecr_access_key=${AWS_ECR_ACCESS_KEY}
aws_ecr_secret_key=${AWS_ECR_SECRET_KEY}
project_name=${PROJECT_NAME}
app_dir="/var/www/$project_name"

main() {
  create_user
  make_app_dir
  configure_ssh
  install_docker
  configure_docker
  install_docker_compose
  configure_docker_compose
  install_python_pip
  install_awscli
  configure_awscli
}

create_user() {
  # Creates a user (by default, named `deploy`)
  # copies the SSH keys from root, and allows using
  # sudo without typing a password (useful for automated scripts)
  useradd --create-home --shell /bin/bash $username
  gpasswd -a $username sudo
  cp -R ~/.ssh /home/$username/
  chown -R $username:$username /home/$username/.ssh
  echo "$username ALL=NOPASSWD:ALL" >> /etc/sudoers
}

make_app_dir() {
  # Creates a directory with the project name, and allows
  # the user access to manage it
  mkdir -p $app_dir
  chown -R $username:$username $app_dir
}

configure_ssh() {
  # Disallow login with the `root` user through SSH
  sed -i 's/RootLogin yes/RootLogin no/' /etc/ssh/sshd_config
  systemctl restart ssh
}

install_docker() {
  # Update repository
  sudo apt-get -y update

  # Install dependencies
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  # Add Docker's repository
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  # Install Docker (Community edition)
  sudo apt-get update -y \
    && apt-get install -y docker-ce
}

configure_docker() {
  # Add user to the Docker group and specify some useful functions
  gpasswd -a $username docker
  echo "export COMPOSE_FILE=$app_dir/docker-compose.yml" >> /home/$username/.profile
  echo "alias dc=docker-compose" >> /home/$username/.profile
  echo "rails() { dc exec web rails \$@ ; }" >> /home/$username/.profile
  echo "rake() { dc exec web rake \$@ ; }" >> /home/$username/.profile
}

install_docker_compose() {
  sudo curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -o docker-compose
  sudo mv docker-compose /usr/local/bin/
  sudo chmod +x /usr/local/bin/docker-compose
}

configure_docker_compose() {
  # Move the previously created docker-compose and traefik config
  sudo mv /opt/docker-compose.yml $app_dir/
  sudo mv /opt/traefik.toml $app_dir/

  # Add an empty environment file and acme.json (for Traefik)
  touch $app_dir/.env
  touch $app_dir/acme.json

  # Close some permissions for acme.json
  sudo chmod 600 $app_dir/acme.json

  sudo chown -R $username:$username $app_dir
}

install_python_pip() {
  # The Ubuntu 16 distro doesn't ship with `pip` in Digital Ocean
  sudo apt-get install -y python-pip
}

install_awscli() {
  # Mostly, used to login to ECR (where we host our Docker images)
  sudo pip install awscli
}

configure_awscli() {
  # Add the Docker profile to the user with ECR credentials
  local aws_dir="/home/$username/.aws"

  mkdir -p $aws_dir

  cat <<EOF > $aws_dir/config
[docker]
output = json
region = us-east-1
EOF

  cat <<EOF > $aws_dir/credentials
[docker]
aws_access_key_id = $aws_ecr_access_key
aws_secret_access_key = $aws_ecr_secret_key
EOF

  chmod 600 $aws_dir/*
  chown -R $username:$username $aws_dir
}

main
