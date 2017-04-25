# Git useful configurations

## Gitconfig file

Add the above lines to `~/.gitconfig`

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
## Git autocompletions

Run the following command from your terminal:

```bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > $HOME/.git-completion.bash
```

And then add to your `.bash_profile` or `.bashrc`:
```bash
source $HOME/.git-completion.bash
```
