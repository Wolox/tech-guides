## Docker guide

First you need to install Docker (https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1)
When you have installed Docker you need to create a Dockerfile, its content will depend on the technology, for example, in .NET Core we use [this definition](https://github.com/Wolox/netcore-bootstrap/blob/master/NetCoreBootstrap/Dockerfile) and in RoR we use [this definition](https://github.com/Wolox/rails-bootstrap/blob/master/Dockerfile)

When you have a Dockerfile you just need to run the following comand to create the docker container
```bash
    docker build -t nectore-bootstrap .
```

With your docker container you can:

#### Deploy to AWS

##### Build Docker image on AWS

AWS has the possibility of directly building a Docker image, allowing us to just push our code (with a valid Dockerfile). 

Before you start, make sure you have a [valid Dockerfile](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/create_deploy_docker_image.html#create_deploy_docker_image_dockerfile) (or just use the one provided in this bootstrap).

1. Download the [Elastic Beanstalk Client](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)
    ```bash
        sudo pip install awswebcli
    ```

2. Configure your access credentials, creating a file in your root folder `~/.aws/credentials`. Make sure it has the following format:
    ```bash
        [profile_name]
        aws_access_key_id = your_access_key
        aws_secret_access_key = your_access_key_secret
    ```

3. Create a Dockerrun.aws.json file in the root directory of your application. It should look like this:
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

4. Initialize Elastic Beanstalk in your application. Make sure the ```profile_name``` is the same one defined on your credentials file:
    ```bash
        eb init --profile profile_name
    ```
    Here, you will be required to select the AWS region you will be deploying to, along with the EB container. You may also be required to select the Docker Version you will be using. 

5. Make sure your environment variables are configured. This can be done from your AWS console, just go to ```Configuration```, then ```Software```. Keep in mind that once you click on ```Apply```, your environemnt will be restarted.

6. Deploy your application with :
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

#### Deploy to Heroku
1. Install Heroku CLI https://devcenter.heroku.com/articles/heroku-cli

2. Log in to heroku with the folloing command:
    ```bash
        heroku login
        heroku container:login
    ```    
3. Create the heroku app with:
    ```bash
        heroku apps:create net-core-deploy-heroku
    ```
4. Tag the heroku target image
    ```bash
        docker tag <image-name> registry.heroku.com/<heroku-app-name>/web
    ```
5. Push the docker image to heroku
    ```bash
        docker push registry.heroku.com/<heroku-app-name>/web
    ```
