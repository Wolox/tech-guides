 #!/bin/sh

 ##################################################################################
 # Script to setup the development environment that we use in Wolox for Mac.      #
 #                                                                                #
 # Usage:                                                                         #
 #   $ chmod +x setup-environment-mac.sh                                          #
 #   $ ./setup_environment-mac.sh                                                 #
 ##################################################################################

 USAGE="

 NAME
           $(basename "$0")
               A simple script that interactively installs:
               zsh,
               ruby, rbenv, bundler,
               wget,
               git, github desktop and setting up aliases,
               google chrome,
               slack,
               atom, sublime text,
               xcode setup, carthage, cocoapods.

 SYNTAX
           $(basename "$0") [ -h ] [ -zsh ]

 OPTIONS
           -h
               Show this help text

 "
USE_ZSH=false

# Helpers

function ask_for () {
  read -p "Do you wish to install $1? (y/n) " yn
    case $yn in
        [Yy]* ) echo 1;;
        [Nn]* ) echo 0;;
        * ) echo "Please answer y or n :)";;
    esac
}

function command_exists () {
  type "$1" &> /dev/null ;
}

function shell_configuration_file () {
  case $SHELL in
    /bin/zsh )
      echo ~/.zshrc;;
    /bin/bash )
      echo ~/.bash_profile;;
    * )
      echo ~/.bash_profile;;
  esac
}

function text_exists_in_file () {
  if [ -f "$2" ] && grep -q "$1" "$2"
  then
    return 0
  else
    return 1
  fi
}

function app_exists () {
  name_without_spaces=$(echo "$1" | sed 's/ //g')
  if [ -d "/Applications/$1.app" ] || [ -d "/Applications/$name_without_spaces.app" ]
  then
    return 0
  else
    return 1
  fi
}

function install_dmg_app () {
  if app_exists "$1"
  then
    echo "$1 is already installed, skipping ..."
  else
    install_wget
    name_without_spaces=$(echo "$1" | sed 's/ //g')

    wget  -O ~/Downloads/$name_without_spaces.dmg "$2"
    hdiutil attach ~/Downloads/$name_without_spaces.dmg
    cp -R /Volumes/$(name_without_spaces)/$name_without_spaces.app /Applications
    hdiutil detach /Volumes/$name_without_spaces
    rm -rf ~/Downloads/$name_without_spaces.dmg
    echo "$1 installed"
  fi
}

function install_zip_app () {
  if app_exists "$1"
  then
    echo "$1 is already installed, skipping ..."
  else
    install_wget
    name_without_spaces=$(echo "$1" | sed 's/ //g')

    wget  -O ~/Downloads/$name_without_spaces.zip "$2"
    unzip -qq ~/Downloads/$name_without_spaces.zip -d /Applications
    rm -rf ~/Downloads/$name_without_spaces.zip
    echo "$1 installed"
  fi
}


#Environment

function install_zsh () {
  if [ -n "$ZSH_VERSION" ]
  then
    echo "Oh My Zsh is already installed, skipping ..."
    echo
  else
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Oh My Zsh successfully installed"
    echo
  fi
}

function install_ruby_environment () {
  echo
  current_shell_configuration=$(shell_configuration_file)

  # - Homebrew
  if command_exists brew
  then
    echo "Homebrew already installed, skipping ..."
  else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebrew installed"
  fi

  # - rbenv
  if command_exists rbenv
  then
    brew update && brew upgrade ruby-build
    echo "Rbenv already installed, skipping ..."
  else
    brew update && brew install rbenv ruby-build
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $current_shell_configuration
    echo 'eval "$(rbenv init -)"' >> $current_shell_configuration
    echo "Rbenv installed"
  fi

  # - Ruby
  # TODO: Check if version 2.3.1 is already installed and avoid installing it.
  rbenv install 2.3.1 && rbenv global 2.3.1 && rbenv local 2.3.1
  echo "Ruby setted up"

  # - Bundler
  if command_exists bundle
  then
    echo "Bundler already installed, skipping ..."
  else
    gem install bundler && rbenv rehash
    echo "Bundler installed"
  fi

  # - Aliases
  alias be='bundle exec'
  echo
  echo "Ruby environment setted up"
  echo
}

function install_wget () {
  if ! command_exists wget
  then
    brew install wget && rbenv rehash
  fi
}


#Git

function install_git () {
  echo
  if command_exists git
  then
    echo "Git is already installed"
  else
    brew install git && rbenv rehash
    echo "Git installed"
  fi
  echo

  install_git_aliases
  install_github_desktop
  echo
}

function install_git_aliases () {
  git_configuration_file=~/.gitconfig
  local aliases=""

  if ! text_exists_in_file "\[user\]" $git_configuration_file
  then
    echo "What's you complete name? "
    read name
    echo "What's your wolox email? "
    read email

    aliases+="[user]
  name = ${name}
  email = ${email}
"
    echo "Added user data to gitconfig"
  else
    echo "User data already added to gitconfig"
  fi

  if ! text_exists_in_file "\[color\]" $git_configuration_file
  then
    aliases+="[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
  ui = auto
"
    echo "Added UI color to gitconfig"
  else
    echo "UI color already added to gitconfig"
  fi

  if ! text_exists_in_file "\[alias\]" $git_configuration_file
  then
    aliases+="[alias]
  co = checkout
  ci = commit
  st = status
  br = branch
  up = pull --rebase origin master
  poh = push origin HEAD
  fp = fetch -p
  lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
  gbr = branch -r
  gac = commit -a -m
"
    aliases+='/tac = "!git commit -a -m"'
    echo "Added alias to gitconfig"
  else
    echo "Alias already added to gitconfig"
  fi

  if ! text_exists_in_file "\[filter" $git_configuration_file
  then
    aliases+="[filter "
    aliases+='"lfs"]'
    aliases+="
  clean = git-lfs clean %f
  smudge = git-lfs smudge %f
  process = git-lfs filter-process
  required = true
"
     echo "Added filters to gitconfig"
   else
     echo "Filters already added to gitconfig"
  fi

  if ! text_exists_in_file "\[push\]" $git_configuration_file
  then
    aliases+="[push]
  default = matching
"
    echo "Added push data to gitconfig"
  else
    echo "Push data already added to gitconfig"
  fi

  echo "$aliases" >> $git_configuration_file
  echo
  echo "Git aliases setted up. You can check them out in $git_configuration_file"
  echo

  autocompletion="
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
"

  current_shell_configuration=$(shell_configuration_file)

  if ! text_exists_in_file "bash_completion" $current_shell_configuration
  then
    brew install bash-completion && rbenv rehash
    echo "$autocompletion" >> current_shell_configuration
  fi
  echo "Git autocompletion setted up for files and branches names"
}

function install_github_desktop () {
  echo
  install_zip_app "GitHub Desktop" "https://desktop.githubusercontent.com/releases/1.0.11-adca8f03/GitHubDesktop.zip"
  echo
}


# Tools

function install_slack () {
  echo
  install_dmg_app Slack "https://downloads.slack-edge.com/mac_releases/Slack-3.0.0.dmg"
  echo
}

function install_google_chrome () {
  echo
  install_dmg_app "Google Chrome" "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
  echo
}

# Tools - Text editor

function install_atom () {
  echo
  install_zip_app Atom "https://atom-installer.github.com/v1.23.2/atom-mac.zip?s=1514939804&ext=.zip"
  echo
}

function install_sublime () {
  echo
  install_dmg_app "Sublime Text" "https://download.sublimetext.com/Sublime%20Text%20Build%203143.dmg"
  echo
}


#iOS

function install_xcode () {
  #Check xcodebuild -version
  echo
  echo "Please install XCode from Infra's disk and then press Enter to continue"
  read

  if ! app_exists XCode
  then
    echo "XCode was not installed correctly. Please reinstall and try again."
    echo
    return
  fi

  if command_exists fastlane
  then
    echo "Fastlane is already installed"
  else
    gem install fastlane && rbenv rehash

    echo "Fastlane installed"
  fi

  echo "Please enter the password for ios-si@wolox.com.ar apple's account: "
  read -s password

  fastlane fastlane-credentials add --username ios-si@wolox.com.ar --password "${password}"

  #Errors:
  #security: SecKeychainAddInternetPassword <NULL>: The specified item already exists in the keychain.
  # TODO: Find a way to check if user already exists - couldn't find it with fastlane

  # TODO: Agregar la passphrase del repo de certificados

  echo "Fastlane setted up"

  echo
}

function install_ios_dependencies_managers () {
  echo
  # Carthage
  if command_exists carthage
  then
    echo "Carthage is already installed"
  else
    brew install carthage && rbenv rehash
    echo "Carthage installed"
  fi

  # CocoaPods
  if command_exists pod
  then
    echo "CocoaPods is already installed"
  else
    sudo gem install cocoapods && rbenv rehash
    pod setup
    echo "CocoaPods installed and setup"
  fi
  echo
}

function install_wolox_ios_repositories () {
  echo
  echo "Please set up your github account with Wolox email and setup SSH key in keychain."
  echo "You can follow this Github guide: https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/"
  echo "Press Enter when finished to continue"
  read
  echo

  mkdir -p ~/Documents/iOS

  #Wolmo Core
  git clone git@github.com:Wolox/wolmo-utils-ios.git ~/Documents/iOS

  #Wolmo Utils
  git clone git@github.com:Wolox/wolmo-core-ios.git ~/Documents/iOS

  #Wolmo Authentication
  git clone git@github.com:Wolox/wolmo-authentication-ios.git ~/Documents/iOS

  #Wolmo Networking
  git clone git@github.com:Wolox/wolmo-networking-ios.git ~/Documents/iOS

  #iOS Scripts
  git clone git@github.com:guidomb/ios-scripts.git ~/Documents/iOS

  #Fastlane Scripts
  git clone git@github.com:Wolox/fastlane-mobile.git

  #iOS Style guides
  git clone git@github.com:Wolox/ios-style-guide.git ~/Documents/iOS

  #Wolox Tech guides
  git clone git@github.com:Wolox/tech-guides.git ~/Documents/iOS

  echo "Wolox github repositories cloned in iOS folder."
  echo "Make sure to bootstrap them before usage."
  echo
}

# Script

function install_apps () {
  # Here we can add as many installers as we want to provide,
  # Everyone should match with a install_name function
  installers=(zsh ruby_environment git google_chrome slack atom sublime xcode ios_dependencies_managers wolox_ios_repositories)
  selected_installers=()

  for i in "${installers[@]}"
  do
    if (($(ask_for $i) == 1))
    then
      selected_installers+=("$i");
    fi
  done

  for i in "${selected_installers[@]}"
  do
    echo "Installing $i"
    install_${i}
  done
}

function main () {
  install_apps

  echo
  echo "All setted up !"
  echo
  echo "Don't forget to install the Logger extension in Chrome !"
  echo
}


while [ "$1" != "" ]; do
  case $1 in
    "-h" | "--help")
      echo "$USAGE"
      exit
      ;;
    *)
      printf "Illegal option: %s\n" "$1" >&2
      echo "$USAGE" >&2
      exit 1
      ;;
  esac
  shift
done

main
