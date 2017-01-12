#!/bin/bash
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
  echo ~/.bashrc
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
  fi
}

install_ruby(){
  if command_exists rbenv; then
    rbenv install $(rbenv install -l | grep -v - | tail -1)
  else
    echo "You need to install Rbenv first!"
    echo "Exiting..."
    exit
  fi
}

install_c_packages() {
  sudo apt-get update
  sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
}

install_postgresql() {
  sudo apt-get update
  sudo apt-get install postgresql-common postgresql
}
# Here we can add as many installers as we want, everyone should match with a install_name function
installers=(rbenv ruby c_packages postgresql)
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
