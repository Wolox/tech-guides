## Elastic Beanstalk environment variable checker

This script finds the environment variables missing in your application's elastic beanstalk instances. For this, it compares the variables you defined in secrets.yml with the variables already defined in each elastic beanstalk instance. You can check several repositories and instances in the same run.

### Requisites

This script assumes that:

1. You have ruby installed
1. You have eb-cli installed
1. Each repository is in the branch needed (release, for example)

Then you need to create a custom JSON file containing the information of your repositories and instances. This JSON file has to follow the format of the one provided [repositories_to_check_example.json](../repositories_to_check_example.json).

The fields in that JSON:

* name: This is an arbitrary name you give to the repository, it's only used to print in the screen.
* path: This is the full path to the repository.
* tech: The options here are: 'rails' and 'node'.
* instances: This are the actual names of all the instances, you can get these from the AWS console.

### Usage

    $ ruby variable_checker.rb /home/user/workspace/repositories.json
