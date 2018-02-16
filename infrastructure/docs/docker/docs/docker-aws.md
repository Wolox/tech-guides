## Deploy to AWS (Building Docker image on AWS)

### Install AWS EB CLI

1. Download the Elastic Beanstalk Client. To do this you can follow the [aws installing tools guide](https://github.com/Wolox/tech-guides/blob/master/infrastructure/docs/aws/docs/aws-eb-deploy.md#installing-the-tools)

2. Configure your access credentials, creating a file in your root folder `~/.aws/credentials`. Make sure it has the following format:
    ```bash
        [profile_name]
        aws_access_key_id = your_access_key
        aws_secret_access_key = your_access_key_secret
    ```

### Create a Dockerrun.aws.json file

#### Configuring only one container in the instance

AWS has the possibility of directly building a Docker image, allowing us to just push our code (with a [valid Dockerfile](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker_image.html#create_deploy_docker_image_dockerfile)). Using this Dockerrun.aws.json, Amazon will build the image in the instance being deployed.

Create a Dockerrun.aws.json file in the root directory of your application.

```bash
    {
    "AWSEBDockerrunVersion": "1",
    "Ports": [
        {
        "ContainerPort": "80"
        }
    ],
    "Volumes": [],
    "Logging": "/var/log/nginx"
    }
```

#### Configuring more than one container in the instance

For some applications it might be necessary to deploy more than one container to the instance. For example:

    * Ruby on Rails app that needs to run the server, sidekiq and redis
    * NodeJS app that needs redis or any other service

In such cases, AWS provides the possibility to deploy more than one container to the same instance. If using this option, AWS will no build the docker images for us. To get this working, you'll need to follow these steps:

    1. Visit [AWS ECS](https://console.aws.amazon.com/ecs/home) and create a new repository for the app image.
    2. Obtain the ElasticBeanstalk instance role in `ElasticBeanstalk` -> `Configuration` -> `Security` -> `Service Role`
    3. Give the ElasticBeanstalk server permissions to access this repository by running: `aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name <instance_role_from_step_2> --profile profile_name`
    4. In the repository root, run the following commands:

```bash
    aws ecr get-login --no-include-email --profile profile_name
    docker build -t my-app .
    docker tag my-app:latest <aws_ecs_repository>/my-app:latest
    docker push <aws_ecs_repository>/my-app:latest
```

    5. Create a Dockerrun.aws.json in the root directory of your application:

```bash
{
  "AWSEBDockerrunVersion": 2,
  "volumes": [],
  "containerDefinitions": [
    /* This will create a container with redis. Port 6379 will be exposed outside the container */
    {
      "essential": true, 
      "image": "redis", 
      "name": "redis", 
      "portMappings": [{
        "containerPort": 6379
      }],
      "memory": 128
    },
    /* This will run the container built in the previous step and run rails server, link redis to it and expose port 3000 through port 80. */
    {
      "name": "app",
      "image": "<aws_ecs_repository>/my-app:latest",
      "environment": [],
      "essential": true,
      "memory": 256,
      "links": ["redis"],
      "mountPoints": [
        /* Logs present in /app/log will be sent to /var/log/container/awseb-logs-app in host computer */
        {
          "sourceVolume": "awseb-logs-app",
          "containerPath": "/app/log"
        }
      ],
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 80
        }
      ]
    },
    /* This will run the container built in the previous step and run sidekiq, link redis to it and expose port 3000 through port 80. */
    {
      "name": "worker",
      "image": "<aws_ecs_repository>/my-app:latest",
      "command": ["bundle", "exec", "sidekiq", "-L", "log/sidekiq.log"],
      "environment": [],
      "essential": true,
      "memory": 256,
      "links": ["redis"],
      "mountPoints": [
      /* Logs present in /app/log will be sent to /var/log/container/awseb-logs-worker in host computer */
        {
          "sourceVolume": "awseb-logs-worker",
          "containerPath": "/app/log"
        }
      ],
      "portMappings": []
    }
  ]
}
```

## Deploy to Elastic Beanstalk

1. Initialize Elastic Beanstalk in your application. Make sure the ```profile_name``` is the same one defined on your credentials file:
    ```bash
        eb init --profile profile_name
    ```
    Here, you will be required to select the AWS region you will be deploying to, along with the EB container. You may also be required to select the Docker Version you will be using. 

2. Make sure your environment variables are configured. This can be done from your AWS console, just go to ```Configuration```, then ```Software```. Keep in mind that once you click on ```Apply```, your environemnt will be restarted.

3. Deploy your application with :
    ```bash
        eb deploy
    ```

    If you are required to select an environment, you can list them using:
    ```bash
        eb list
    ```

    And deploy using:
    ```bash
        eb deploy environment_name
    ```
