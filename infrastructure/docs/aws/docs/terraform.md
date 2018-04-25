# Creating the infrastructure using Terraform

Terraform allows to create infrastructure from code using a CLI. To standarize our infrastructure across projects, we've developed [these terraform modules](https://github.com/Wolox/terraform-base-infra). With these modules, you can create:

- [Elastic Beanstaslk environment + RDS](https://github.com/Wolox/terraform-base-infra#elasticbeanstalk--rds)
- [S3 Website with a Cloudfront distribution](https://github.com/Wolox/terraform-base-infra#s3-website)

The steps to build your infrastructure using this approach are:

1. [Install Terraform](#installing-terraform)
2. [Get your AWS Keys](#getting-aws-keys)
3. [Create your Terraform file](#create-your-terraform-file)
4. [Apply changes](#apply-changes)

## Installing Terraform

You can install Terraform by visiting the [official documentation](https://www.terraform.io/intro/getting-started/install.html). Make sure you download the binary in a folder you will not delete later. A good place to put your terraform binary is in `/usr/local/bin/` by executing `sudo mv terraform /usr/local/bin/`

Verify the installation running `terraform --version`

## Getting AWS Keys

### Create IAM user

If you don't have an AWS User, you'll first need to create it. If you already have one, jump to [Generate AWS Access Keys](#generate-aws-access-keys)

To create an IAM User, follow these steps:

* Visit [IAM Dashboard in AWS](https://console.aws.amazon.com/iam/home).
* Visit the *Users* section.
* Click *Create User* button and follow the instructions. Be sure to allow *Programmatic access*.
* In the permissions section, add the following existing policies:
  - AWSElasticBeanstalkFullAccess
  - AmazonVPCFullAccess
  - AmazonS3FullAccess
  - AmazonRDSFullAccess
  - IAMFullAccess

### Generate AWS Access Keys
In order to access your AWS account to create the infrastructure you will need to provide an access key and access secret.

If you already have the access keys, jump to [Configure AWS Keys Locally](#configure-aws-keys-locally). If not, follow these steps:

1. Visit [IAM Dashboard in AWS](https://console.aws.amazon.com/iam/home).
2. Visit the *Users* section and find your username.
3. In the user's detail page, click on the *Security Credentials* tab. Inside that tab you'll see a button with the label `Create Access Key`. If the button is grayed-out, you will need to delete one of the existing keys to add a new one.

### Configure AWS Keys Locally

To start, create the following files:
* `~/.aws/credentials`
* `~/.aws/config`

Append the following content to `~/aws/credentials`:

```
[the-name-of-your-profile]
aws_access_key_id=your-access-key
aws_secret_access_key=your-access-secret
```

Append the following content to `~/aws/config`:

```
[the-name-of-your-profile]
region = us-east-1
```

## Create your terraform file

For any of the cases below, you'll need to create a file with `.tf` extension. This file will contain the necessary code to generate the infrastructure.

### Elastic Beanstalk + RDS

You will first need to create a Key Pair that will allow SSH connections to the instance. To do so, visit the [EC2 dashboard](https://console.aws.amazon.com/ec2/v2/home) and select Key Pairs. Click on *Create Key Pair* and save the file that the browser automatically downloads.
Change the file permissions by running `chmod 600 <key-name>` and then move it to `~/.ssh` by running `mv <key-name> ~/.ssh`.

Visit [this page](https://github.com/Wolox/terraform-base-infra#elasticbeanstalk--rds) to find an example template.

Be sure to replace the default values and *don't forget to change the Key Pair name* to the one downloaded in the previous step.

### S3 Website

Visit [this page](https://github.com/Wolox/terraform-base-infra#s3-website) to find an example template.

## Apply changes

Once the `.tf` file is complete and the default values were replaced, run `terraform init`. This will import everything necessary from the main repository.

After the init run `terraform plan`. This will generate a plan an list all the resources to be created. If you're ok with this, run `terraform apply`. This will re-run the plan and promp for your confirmation to create the infrastructure. Type `yes` and let Terraform do it's job

```
terraform init # only needed the first time
terraform plan # will output a plan, showing which resources to create
terraform apply # will prompt for confirmation and apply the changes
```

## FAQ

### How can I rebuild an Elastic Beanstalk environment ?

If for some reason you need to rebuild your ElasticBeanstalk environment, you can follow these steps:

1. In the [AWS ElasticBeanstalk Dashboard] (https://console.aws.amazon.com/elasticbeanstalk/home) visit the environment you would like to rebuild
2. In the *Actions* button in the upper right hand side click on *Terminate Environment*. This will destroy all the servers and associated resources
3. Once it's done, run `terraform apply`. The deleted environment should be created again

### How can I see the Elastic Beanstalk Logs

There are two possible ways to see the server logs:

#### Download logs from the AWS Dashboard

In the [AWS ElasticBeanstalk Dashboard] (https://console.aws.amazon.com/elasticbeanstalk/home) visit the environment from which you want to get the logs. On the left hand side, click on *Logs* and then *Request Logs*.

#### SSH to the instance and watch them live

Take a look at [this readme](./aws-eb-deploy) and follow the steps. You'll find a section called *Connecting by SSH*.

All the interesting logs will be found at `~/var/log/...`. Some interesting files:

* `/var/log/eb-activity.log`: shows all the commands being processed by the instance. This is useful when deploying, to see what's going on
* `/var/log/puma/...`: If you're working with a Rails project, you'll find Puma logs in here
* `/var/log/eb-docker/...`: If you're working with Docker, you'll find your app logs here.
