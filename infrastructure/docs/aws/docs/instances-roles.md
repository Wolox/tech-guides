# Instance Profiles

## Introduction

Instance profiles provide a way of assigning AWS credentials in a secure way to an Amazon instance. They can be used in EC2 instances, Elastic Beanstalk environments, Lambda functions, etc.

Using Instance Profiles saves us from having to add AWS credentials as Environment Variables. Amazon does that for us and it also rotates them for security. Hence, we don't need to initialize the AWS SDK in this way any more:

`ec2 = Aws::EC2::Client.new(region: region_name, credentials: credentials)`

We can simply instantiate it like this:

`ec2 = Aws::EC2::Client.new(region: region_name)`

If we need to test something locally we can add these lines to `.env` file:
```
AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
```

and then load those variables using `source .env`

Using https://github.com/bkeepers/dotenv will save you from executing `source .env`

## Configuration

In order to use Intance Roles, we first need to create said Role in IAM. To achieve this, go to [IAM](https://console.aws.amazon.com/iam/home?region=us-east-1).

Once there, go to Roles -> Create New Role

1. Enter the name of the role. It must be self-describing.
2. Select Role Type: Choose *Amazon EC2*
3. Select the permissions our instance needs
  * If we are doing this for an Elastic Beanstalk environment, make sure to add:
    * AWSElasticBeanstalkWebTier
    * AWSElasticBeanstalkMulticontainerDocker
    * AWSElasticBeanstalkWorkerTier
    
With the Role created, we now need to create a Policy that will determine what this role can do. To do so, inside IAM go to 
 Policies -> Create Policy. It is strongly recommended to use the Policy Generator to build the policy in an easy way.
Multiple accesses can be added using the Policy Generator.

We must now associate this newly created policy with the previously created Role. To do so:
1. Find the Role
2. Click Attach Policy
3. Find the policy and associate it

Finally we must associate the Role with the instance or the Beanstalk Environment.

* If we are working with a Beanstalk environment, just go to Configuration -> Instances in the Beanstalk Environment and change the Instance Profile.
* If it is an EC2 instance, it must be configured at creation time

Once finished, our instance should have the permissions that the policy allows. If these permissions need to be changed, just change the policy and that should do it.
