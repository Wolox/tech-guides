# Wolox Recommendations for Github Branches Protection

We believe `master` should only have productive code.
And as such, we believe it should be a protected branch were only specific commits can reach it.

So in the repository, you should add master as a protected branch with the following protections enabled:

- [x] Require pull request reviews before merging (with at least one approved review)
- [x] Require status checks to pass before merging (Check [this](./pull-requests-good-practices.md#pull-request-webhooks) to set up status checks)
- [x] Require branches to be up to date before merging
- [x] Restrict who can push to this branch (with specific authorized collaborators for it)

So instead of using `master` as the every day development branch, you should have another branch for it (for example, `development` or `version1`).

Feel free to add more restrictions to `master` branch or any other branch your project may use (this will vary according to your branching model).
