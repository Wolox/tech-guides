Add the above lines to ~/.gitconfig

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
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
[branch "development"]
    remote = origin
    merge = refs/heads/development
[help]
    autocorrect = 10
```
