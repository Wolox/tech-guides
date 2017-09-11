NET CORE Kickoff guide
-------------------------

The following guide explains how to make a NET Core project kickoff from scratch.

## Requirements

Before you start with this step by step guide you will need the following:
* Access to the Github repository where the code of the kickoff will be hosted.

## Kickoff

The following steps will help you have a NET Core project ready for new features. We are going to use an example project with the name `app-name`. Everytime you see `App Name` in this guide, you must replace it with your project name. It is important to respect all the name conventions.

### Clone and project base setup

#### Adding base project

The first thing you need to do is to clone the [base project](https://github.com/wolox/netcore-bootstrap) we have at Wolox that includes many of the common tools we use everyday, in almost every project.

Then we are going to create a development branch so we can make an pull request to master and check the CI integrations. It is important that you leave master empty.

First, make sure you have the latest version of the [NetCore Bootstrap](https://github.com/wolox/netcore-bootstrap). Then, run the following commands:
```bash
    cp -r netcore-bootstrap/ app-name
    cd app-name
    rm -rf .git
    git init
    git remote add origin git@github.com:Wolox/app-name.git
    git commit --allow-empty -m 'Initial Commit'
    git push origin master -f
    git checkout -b development
```

To change all the names of the base project to the one you really want, you need to run a script.
To do so, follow the next steps:
1. Set access permissions to init script:
```bash
    chmod +x ./Scripts/script.sh
```
2. Change the AppName:
If you don't need the authentication module, run: 
```bash
    ./Scripts/script.sh AppName delete-auth
```
Else just run:
```bash
    ./Scripts/script.sh AppName
```
(Remember, `AppName` must be your project name)

This will replace all the `NetCoreBootstrap` instances in the base project with `AppName`

Now you are ready to make the Initial Commit code by running:

```bash
    cd app-name
    git add .
    git commit -m "Kickoff"
    git push origin development
```

You can now start hacking with NetCore! Have fun!
