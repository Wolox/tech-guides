Java Kickoff guide
-------------------------

The following guide explains how to make a Java project kickoff from scratch.

## Requirements

Before you start with this step by step guide you will need the following:
* Access to the Github repository where the code of the kickoff will be hosted.

## Kickoff

The following steps will help you have a Java project ready for new features. We are going to use an example project with the name `app-name`. Everytime you see `AppName` in this guide, you must replace it with your project name. It is important to respect all the name conventions.

### Clone and project base setup

#### Adding base project

The first thing you need to do is to clone the [base project](https://github.com/wolox/java-bootstrap) we have at Wolox that includes many of the common tools we use everyday, in almost every project.

Then we are going to create a development branch so we can make an pull request to master and check the CI integrations. It is important that you leave master empty.

First, make sure that you have the latest version of the [Java Bootstrap](https://github.com/wolox/java-bootstrap). Then, run the following commands:
```bash
    cp -r java-bootstrap/ app-name
    cd app-name
    rm -rf .git
    git init
    git remote add origin git@github.com:Wolox/app-name.git
    git commit --allow-empty -m 'Initial Commit'
    git push origin master -f
    git checkout -b development
```

WIP: Run the script to finish the app

Now you are ready to make the Initial Commit code by running:

```bash
    cd app-name
    git add .
    git commit -m "Kickoff"
    git push origin development
```

You can now start hacking with Java! Have fun!
