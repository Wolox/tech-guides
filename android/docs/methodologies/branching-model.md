**WOLOX - ANDROID**

#Branching Model / Android

## User Stories - EPIC

The branching model we use at the Android department in Wolox is based on the concept of **Epics** or **User Stories**. Even though there are several definitions of what an epic or a user story is, in Wolox we define them as a group of tasks that represents an entire functionality and adds value for the user. An epic is useful only if it has a defined purpouse and if every task that it envolves has been completed.

## QA

One of the advantages of working with the concept of epics is that we can simplify the QA process for both devs and testers. With this model, only a completed epic is sent to the QA team, resulting in time savings in comparison to building a new `.apk` per each task. This also allows the QA team to test the functionality as whole, making testing easier and more accurate and ultimately resulting in a product with a higher quality.

## Branchs

### `master`

The branch `master` contains the latest stable release of the project. Also, the code in this branch must have been approved by the client.

_Trello column associated to this branch: Approved by Client and subsequent columns._

### `dev`

The branch `dev` comes from `master`. In the `dev` branch we can found the epics that were approved by the QA team. Periodically, when the current sprint is over or when clients give their approval, this branch is merged to `master` after carefully testing that each merged epic works as intended with each other. The `master` branch must never have code that is not working properly.

_Trello column associated to this branch: QA Approved, Stage._

### `epic-{epic name}`

Each epic's branch has the commits of the tasks that have been through Code Review and whose Pull Requests where approved. Once that each of one of the epic's tasks has been approved in Code Review, an `.apk` is build from this branch and it is send to the QA team after rebasing from `dev`.

_Trello column associated to this branch: Developed._

### `{epic name}-{feature name}`

The branch of each feature or task starts from the epic branch to which it corresponds. Here the developer performs the necessary commits to implement the desired functionality. Once it is finished, it is this branch that is sent to Code Review, making a Pull Request that has as destination the branch of the epic.

_Trello column associated to this branch: Doing._

## Practical example

### Planning

Suppose a project that already has a released version and where `master` and` dev` are synchronized. In the planning of the next sprint, it is defined that the following functionalities will be developed:

* Screen "A" redesign

* A new "B" screen

* Push notifications implementation

To accomplish this, 3 branches are made from `dev`:

* `epic-screen-A-redesign`

* `epic-screen-B`

* `epic-push-notifications`

In the planning it is defined who will be in charge of each epic. This person must create the epic's branch and push it to the repository. Additionally, this person will be responsible for setting up the Test Plan and sending the `.apk` to QA once the epic is developed. Even though only one developer is in charge of each epic, there may be other developers who work on that epic as well.

### Definition of tasks by EPIC

During the planning, the cards that belong to each epic may be defined. If the whole team is not present during the planning, the developers will be in charge of defining appropiate tasks and Trello cards for them. Considering the example of the new screen "B" to be implemented, suppose that 3 cards are defined, with their corresponding branches that come out of `epic-screen-B`:

* `screen-B-design` where the design / frontend of the view is done

* `screen-B-backend` where presenters, services, etc. are implemented

* `Screen-B-flow` where the "connection" of the new screen is made with the flow of the existing app

It is not strictly specified how many developers must participate in each epic; This is at the discretion of each team.

### Merging to the `epic` branch from a task branch

Once the branches were merged and the rebased to `dev`, it's time to send `epic-screen-B` to QA. Here the testers that work on that epic indicate the errors found. These errors are corrected on a new branch for fixes (for example `screen-B-qa-fixes`) and a Pull Request is created to merge this branch to the one of the epic. Once it is approved, the fixes are merged and an `.apk` is send from the` epic-screen-B` branch to QA. If QA approves the changes, the epic branch is merged to `dev`

###  Merging to `master` from `dev` branch

At the end of the sprint (with the 3 new epics in `dev`) a demo is made with the client, who approves the functionalities and `dev` is merged to `master`. It is possible that in some projects this is not done in each sprint, but with the periodicity that the client prefers (coordinating this with the development team). Each time a release is made (to Google Play), a tag is made in `master` with the version of the release, respecting the format `vX.Y.Z`. That tag has to be something that can be zipped and delivered to the client. In addition, it must be in an stable state that can be rollbacked if necessary.

## Considerations for small-sized development teams

* If the development team is made up of a single developer, it may be more convenient to rely on `dev` and` master` branch only. With this configuration, the developer creates a new branch starting from `dev` for each card and as each one ends, creates a new Pull Request to merge this branch with `dev`. In any case, the methodology of having QA-approved code in `dev` and approved by the client in `master` with a version tag must be maintained.

* If you choose not to have `epic-xxx` type branchs, groups of cards must be defined to be tested by the QA team. The idea is to maintain a testing methodology similar to EPICs, but with a smaller number of branches that simplify development in small teams.
