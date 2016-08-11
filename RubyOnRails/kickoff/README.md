Ruby On Rails Kickoff guide
-----------------

The following guide explains how to make a Ruby On Rails (RoR) project kickoff from scratch. Depending on who is making the kickoff, it may lack access to execute some steps from this guide. In that case, get in touch with someone that can grant those access. They can be granted by [TMS](mailto:tms@wolox.com.ar), [TLS](mailto:tls@wolox.com.ar) or [Santiago Samra](mailto:santiago.samra@wolox.com.ar).

The Technical Leaders of the RoR department can help you with the steps from this guide or grant you the necessary access needed. Any doubt get in touch with:

 * [Esteban Pintos](mailto:esteban.pintos@wolox.com.ar)
 * [Matias De Santi](mailto:matias.desanti@wolox.com.ar)

## Requirements

Before you start with this step by step guide you will need the following:
  * Access to the Github repository where the code of the kickoff will be. If the repository is not created ask the TM from this project for it.
  * Verify that the developers group email of the project is working. It should have the format: `PROJECT_NAME-dev@wolox.com.ar`. You can ask the TM from this project to create the email team.
  * Admin access to [Wolox CI](http://ci.wolox.com.ar).
  * Admin access to [CodeClimate](https://codeclimate.com/).

## Kickoff

The following steps will help you have a RoR project ready for new features. We are going to use an example project with the name `example-project`. Everytime you see `Example Project` in this guide, you should replace it with your project name. It is important to respect all the name conventions. For example, if you see `Example Project` in this guide, you should replace it and respect the CamelCase notation.

### Clone and project base setup

#### Adding base project

The first thing you need to do is to clone the base project we have at Wolox that includes many of the common tools we use everyday, in almost every project.

For this open your terminal and execute:

  ```bash
    git clone git@github.com:Wolox/rails-bootstrap.git
    cd ..
    cp -r rails-bootstrap/ example-project
    cd example-project
    rm -rf .git
    git init
    git remote add origin git@github.com:Wolox/example-project.git
  ```

Then you need to run the script that changes all the names of the base project to the one you really want. To do this run:

```bash
    ./script/bootstrap example-project
  ```

This will replace all the `RailsBootstrap` things in the base project with `ExampleProject`

Now you are ready to commit the Initial Commit code by running:

  ```bash
    git add .
    git commit -m "Initial commit"
    git push origin master -f
  ```

## CodeClimate

[CodeClimate](https://codeclimate.com/) gives us metrics about code coverage and code quality of the code. We use the `development` branch as a base branch for all the features. So lets create this branch and setup CodeClimate:

  ```bash
    git checkout -b development
    git push origin development
  ```
Now go to [CodeClimate](https://codeclimate.com/) and add the project Github repository. Be sure to select `development` as the base branch to analyze.

Then you will need to create a new Team for the developers to access the metrics. For this add a `ExampleProject` team and add all the developers that need access.

Also assign `Owners` and `Code Reviewers` teams to the project. Those teams are already created.

Now go back to your code and replace the Coverage and GPA badge from the `README.md` of the project.

## Wolox CI

## Github configuration

[Wolox CI](http://ci.wolox.com.ar) will run tests, linters and other checks everytime someone creates a Pull Request, changing the build status when it finishes. Wolox CI runs with [Jenkins](https://jenkins.io/). Github sends a webhoook to Wolox CI everytime a new Pull Request is created, so you will need to setup this first. You will need to access [http://ci.wolox.com.ar/authorize?project=example-project&tech=rails](ci.wolox.com.ar/authorize?project=example-project&tech=rails) repacling `example-project` again.

This will create a new Credential in Jenkins and create an `Example-Project` under the `Actives Pull Requests` tab and an `Example-Project-Base` and the `Actives Base Branch` tab. Notice the name of the Credential that is created.

Go back to [Wolox CI](http://ci.wolox.com.ar) and press the `Actives Pull Requests` tab and find `Example-Project`. Go to `configure` in the left sidebar.

This will redirect you to the new project configuration page where you need to replace `ror-example-project` with `example-project`. The things you need to replace are:

 - Project url
 - Repository URL and Credential. Here you should be able to choose from the dropdown a credential called `example-project`.
 - Email Notification Recipients with the developers team mail already mentioned above.
 - In `Projects to build` you need to add `Example-Project-Base`. Don't forget the `Base` part.

Press `SAVE`.

Now you need to modified the Base branch that was automatically created before. You need to do a similar step as before:

Go back to [Wolox CI](http://ci.wolox.com.ar) and press the `Actives Base Branch` tab and find `Example-Project-Base`. Go to `configure` in the left sidebar.

Like we did before, replace:

 - Project url
 - Repository URL and Credential. Here you should be able to choose from the dropdown a credential called `example-project`.
 - Email Notification Recipients with the developers team email already mentioned above.

Press `SAVE`.

With all this setup, the pull requests will start running with Wolox CI. We are missing the access grant for the developers.

Go to [http://ci.wolox.com.ar/role-strategy/manage-roles](http://ci.wolox.com.ar/role-strategy/manage-roles). In `Role to add` add your new project name. For example: `Example-Project` and in `Pattern` add your project name with `*.*` at the end. For example: `Example-Project*.*`. Press `Add`. A new row will be added to the `Project roles` table. In that row check the `Build` `Read` and `ViewStatus`. Then press `Save`.

![WoloxCI New Credential](./resources/woloxci-manage-roles.png)

Now go to [http://ci.wolox.com.ar/role-strategy/assign-roles](http://ci.wolox.com.ar/role-strategy/assign-roles). Here you will grant access to the developers one by one to the project. First be sure the developer is added to the `Global roles` table with `wolox` option checked. Then go to the `Project roles` tables and check the project name in the user role. Then press `Save`. If you don't know the username you need to add, you can check them [here](http://ci.wolox.com.ar/asynchPeople/). Repeat this for all of the developers.

You can now add the Wolox CI badge to the `README.md`. The url will be `[![Build Status](http://ci.wolox.com.ar/buildStatus/icon?job=Example-Project)](http://ci.wolox.com.ar/job/Example-Project)`. Replace `Example-Project` with your Wolox CI project.

### Update README.md

Lets add some project details to the `README.md` to finish with the Kickoff. Replace all the variables with a `%` with its corresponding value. They should go below the project title on top of the file:

* `%project-description`: Brief description of the project.
* `%pm-full-name`: Full name of the TM of the project with a link to its email.
* `%tl-full-name`: The full name/s of the TL/s of the project with a link to their email.
* `%project-trello-url`: URL of the Trello Board.
* `%project-google-drive-url`: URL of the Google Drive folder.

You are now ready to make a new commit and test everything.

  ```bash
    git add README.md
    git commit -m 'Kickoff'
    git push origin development
  ```

You can know make a Pull Request to test either the Wolox CI build and the CodeClimate integration. After all this works you are ready to merge to master.

## Rollbar

When the projects is deployed to Stage or Production it will need a dashboard to show all the exceptions raised. For this we use [Rollbar](https://rollbar.com/). Let's see how to setup the project here.

#### Create account

First we need to create an account that will have all the tecnologies of the project. Enter [here](https://rollbar.com/account/create/) and insert `EXAMPLE-PROJECT`.

![Rollbar New Account](./resources/rollbar-create-account.png)

#### Create Wolox Team.

Enter [https://rollbar.com/settings/accounts/EXAMPLE-PROJECT/teams/](https://rollbar.com/settings/accounts/EXAMPLE-PROJECT/teams/) replacing `EXAMPLE-PROJECT` with your new account name. Press `New Team` and enter `Wolox`. In the following page add all the developers that need access:

![Rollbar Wolox Team](./resources/rollbar-wolox-team.png)

Go back to the `Owners Team` and add the TM email.

#### Create Project

Now let's add the new RoR project. Enter [https://rollbar.com/settings/accounts/EXAMPLE-PROJECT/projects/](https://rollbar.com/settings/accounts/EXAMPLE-PROJECT/projects/) replacing `EXAMPLE-PROJECT` with your new account name. Let's delete the `FirstProject` that its always added by default. Then under `Create a new project` insert your project name in Camel-Case separated by `-`, and assign `Wolox` as a team. Don't forget to add the technology at the end of the name of the project. This will make the emails more clear.

![Rollbar New Project](./resources/rollbar-new-project.png)

### Notify TM

Now that your Kickoff is ready. Notify the TM about this by email. The TM should ask [Santiago Samra](mailto:santiago.samra@wolox.com.ar) to grant access to the developers to the Github Repo.
