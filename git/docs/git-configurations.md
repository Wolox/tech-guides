# Git useful configurations

If you have OSX, you can run the git installation from [this](../useful-scripts/scripts/setuo-environment-mac.sh) script and this configuration will be set for you.

## Gitconfig file

Add the following lines to `~/.gitconfig`

```
[user]
    name = firstName lastName
    email = yourEmail@wolox.com.ar
[color]
    diff = auto
    status = auto
    branch = auto
    interactive = auto
[core]
    editor = vim
    quotepath = false
[alias]
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
    ac = "!git commit -a -m "
[help]
    autocorrect = 10
[filter "lfs"]
    clean = git-lfs clean %f
    smudge = git-lfs smudge %f
    required = true
[color]
    diff = auto
    status = auto
    branch = auto
    interactive = auto
    ui = auto
[push]
    default = matching
```

## Git autocompletions

### Ubuntu

Run the following command from your terminal:

```bash
sudo apt-get install git bash-completion
```

### OSX

1. [Install homebrew](https://brew.sh/).
2. Run from terminal:
```bash
brew install git bash-completion
```
3. Add to `~./bash_profile` file:
```
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
```
4. Restart terminal.
