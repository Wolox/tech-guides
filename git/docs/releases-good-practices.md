# Wolox Good Practices for Releases

A release is an important event in a project and it should not go unnoticed.

Releases should follow the _semantic versioning_ format.

## Release tags

Everytime the project has a release made to the final user or any important stakeholder,
there should be a tag in the repository to register the exact code we deliver each time.

There could even be a tag for each testing version delivered.

## Release notes

If your project is **open-sourced** and delivers releases through Github,
you should accompany the release with a clear and complete note on the changes made.

Here's an example to base on:

```
Release meant for <environment requirements, like **OS**, **IDE** or **Language** version>.

### Summary

Brief description of the overall changes.

### Breaking changes

Summary of the breaking changes.
You may link to important PRs that may clarify doubts about it.

### Changes

This is where a more detailed information is provided.
Ideally you would have a CHANGELOG.md file to link here.

This is also a perfect place to mention all contributors that made PRs,
raised issues or created functionalities, which affected this release.
```
