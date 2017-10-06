# Deploy in AWS

## Introduction

This document is intended to be a guideline to show you how to configure your computer for deployment into the Amazon Web Services. You may contact with the developers in the team, the Architect or Scum Master for the files needed.

## Installing the tools

Get into these links and follow the instructions to install the Elastic Beanstalk command line interface.

- http://docs.aws.amazon.com/cli/latest/userguide/installing.html
- http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html

## Setting up your environment

In yours computer’s *home* folder you must create the folder `.ssh` and put the `<project-name.pem>` file.

> With Ctrl + H you can hide and show the hidden folders (the ones that start with a dot)

Then you must set the correct permissions for this file running:

```
chmod 600 <project-name.pem>
```

### Set up your credentials

In the terminal run

```
aws configure
```

You must provide the **AWS Access Key ID**, **AWS Secret Access Key** and the **region** which will be sent to you at the beginning of the project by email or other means. You may leave the output format empty.

> Usually we use the `us-east-1` region

If you had already set up the default profile, you can create new profiles by using the option `--profile <profile-name>` in the previous command.
To use a specific profile with the other commands you run, you must add also the `--profile <profile-name>` option.

> If you need to check the credentials you had set up you can see the content of the files ~/.aws/config and ~/.aws/credentials

### In your project

With the terminal in the root folder of your project, you must run the following command

```
eb init
```

> Add `--profile <profile-name>` option if needed

This will prompt some steps in your terminal to set up your application and environment by default for this project in AWS.

After running this command this will create a `.elasticbeanstalk` folder with your project configuration.

## Deploy

Only the committed changed will be deployed to Elastic Beanstalk, so always remember to commit or run a `git pull origin <branch-name>` before deploying.

In the root folder of your project run

```
eb deploy <environment-name-in-aws>
```

> Add `--profile <profile-name>` option if needed

## Connecting by SSH

In the root folder of your project run

```
eb ssh <environment-name-in-aws>
```

A fingerprint confirmation will prompt in your terminal, write `yes`.

### Watching the logs while the deploy runs

Run the command after connecting by *ssh*:

```
tail -f /var/log/eb-activity.log
```

This opens a live stream of the changes that are taking place in the deploy and will show any error that occurs

### Running the Rails console

Also you can open a Rails console in the instance to run queries, create objects, etc.

```
cd /var/app/current
rails c
```

### Logs access

You can access the latest logs from the instance by running

```
eb logs
```
