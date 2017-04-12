#!/bin/bash
##################################################################################
# Script to setup the development environment that we use in Wolox for Ubuntu 16 #
#                                                                                #
# Usage:                                                                         #
#   $ chmod +x setup-environment.sh                                              #
#   $ ./setup_environment.sh                                                     #
##################################################################################
echo "Welcome to the rails instalation"

ask_for(){
  read -p "Do you wish to install $1? (y/n)" yn
    case $yn in
        [Yy]* ) echo 1;;
        [Nn]* ) echo 0;;
        * ) echo "Please answer y or n :)";;
    esac
}

shell_configuration_file(){
  case $SHELL in
    /usr/bin/zsh )
      echo ~/.zshrc;;
    /usr/bin/bash )
      echo ~/.bashrc;;
    * )
      echo ~/.bashrc;;
  esac
}

command_exists () {
  type "$1" &> /dev/null ;
}

# Installation scripts
install_rbenv() {
  current_shell_configuration=$(shell_configuration_file)
  if command_exists rbenv; then
    echo "Rbenv is already installed, skipping..."
  else

    if ! [ -d ~/.rbenv ]; then
      git clone https://github.com/rbenv/rbenv.git ~/.rbenv
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $current_shell_configuration;
      echo 'eval "$(rbenv init -)"' >> $current_shell_configuration;
    fi

    if ! [ -d ~/.rbenv/plugins/ruby-build ]; then
      git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
      echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> $current_shell_configuration;
    fi
    export PATH="$HOME/.rbenv/bin:$PATH"      
    eval "$(rbenv init -)"
  fi
}

install_ruby(){
  if command_exists rbenv; then
    latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
    read -e -p "Please enter the Ruby version you want to install: " -i "$latest_ruby_version" ruby_version
    rbenv install $ruby_version
  else
    echo "You need to install Rbenv first!"
    echo "Exiting..."
    exit
  fi
}

install_rails(){
  if command_exists gem; then
    # Little hack to get the newest version of the gem,
    latest_rails_version=$(gem search '^rails$' --all | grep -o '\((.*)\)$' | tr -d '() ' | tr ',' "\n" | sort -r | head -n1)
    read -e -p "Please enter the Rails version you want: " -i "$latest_rails_version" rails_version
    gem install rails -v $rails_version
  else
    echo "You need to install ruby first!"
  fi
}

install_nvm() {
  current_shell_configuration=$(shell_configuration_file)
  if [ -d ~/.nvm ]; then
    echo "NVM is already installed, skipping..."
  else
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
  fi
  source ~/.nvm/nvm.sh
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  echo 'export NVM_DIR="$HOME/.nvm"'  >> $current_shell_configuration;
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> $current_shell_configuration;
}

install_c_packages() {
  sudo apt-get update
  sudo apt-get install ruby-dev libgmp-dev git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
}

install_postgresql() {
  sudo apt-get update
  sudo apt-get install libpq-dev postgresql-common postgresql
  read -e -p "Username for postgresql (dev by default): " -i "dev" username_pg
  read -s -e -p "Password for postgresql (dev by default): " password_pg
  if [[ -z "${param// }" ]]; then
    password_pg="dev"
  fi
  psql -c "CREATE ROLE \"$username_pg\" WITH LOGIN SUPERUSER PASSWORD '$password_pg' ;"
}

install_node() {
  nvm install node
}

install_atom() {
  rm -f /tmp/atom.deb
  curl -L https://atom.io/download/deb > /tmp/atom.deb
  sudo dpkg --install /tmp/atom.deb
  rm -f /tmp/atom.deb

  apm upgrade --confirm false
}

install_heroku_cli() {
  sudo add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
  curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install heroku
}

install_python() {
  current_shell_configuration=$(shell_configuration_file)
  sudo apt-get install python3.4
  curl -O https://bootstrap.pypa.io/get-pip.py
  rm ./get-pip.py
  python3 get-pip.py --user
  echo 'export PATH=~/.local/bin:$PATH' >> $current_shell_configuration;
  source $current_shell_configuration;
}

install_elastic_beanstalk() {
  if ! command_exists pip; then
    install_python
  fi
  sudo pip install awsebcli --upgrade --user
}

install_google_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sudo add-apt-repository "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"
  sudo apt-get update 
  sudo apt-get install google-chrome-stable
}

# Here we can add as many installers as we want to provide,
# Everyone should match with a install_name function
installers=(c_packages rbenv ruby rails postgresql nvm node atom elastic_beanstalk heroku_cli google_chrome)
selected_installers=()

for i in "${installers[@]}"
do
  if(($(ask_for $i) == 1)); then
    selected_installers+=("$i");
  fi
done

for i in "${selected_installers[@]}"
do
  echo "Installing $i"
  install_${i}
done

