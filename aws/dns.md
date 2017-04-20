# Configuring DNS in AWS

## Getting started

The first thing to do is create a hosted zone. To do so, visit [Route 53's page](https://console.aws.amazon.com/route53/home?region=us-east-1#hosted-zones:) 
and click on *Create Hosted Zone*. Enter the desired domain name (e.g. my-website.com)

## Create DNS entry for AWS Elastic Beanstalk Application

In your hosted zone:

1. Click on Create Record Set
2. Enter the record name (e.g. api.my-website.com)
3. Select CNAME in the Type dropdown
4. Select No in the alias option
5. In the text area copy the Beanstalk Environment url

## Create DNS entry for a static website hosted in S3

In your hosted zone:

1. Click on Create Record Set
2. Enter the record name (e.g. api.my-website.com)
3. Select A – IPv4 address in the Type dropdown
4. Select Yes in the alias option
5. Alias Target: In the S3 website endpoints section of the list, choose the bucket that has the same name that you specified for Name.
6. Routing Policy: Accept the default value of Simple.
7. Evaluate Target Health: Accept the default value of No.

## Delegating domains to AWS

In your hosted zone you'll find an entry with type `NS`. Take note of the values of that entry.

### Delegating from GoDaddy

1. Login to your GoDaddy account.
2. Select Domains from under the Product tab and click on Manage beside the domain you want to delegate.
3. Click Enter Custom Nameservers and enter the values you found in AWS entry with type `NS`. All 4 of AWS’ nameservers must be represented in your domain delegation.
4. Click OK and then Save.
