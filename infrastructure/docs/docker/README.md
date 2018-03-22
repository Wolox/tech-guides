## Docker guide

First you need to install Docker (https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1)
When you have installed Docker you need to create a Dockerfile, its content will depend on the technology, for example, in .NET Core we use [this definition](https://github.com/Wolox/netcore-bootstrap/blob/master/src/Dockerfile) and in RoR we use [this definition](https://github.com/Wolox/rails-bootstrap/blob/master/Dockerfile)

When you have a Dockerfile you just need to run the following comand to create the docker container
```bash
    docker build -t nectore-bootstrap .
```

With your docker container you can:
- [Deploy to AWS](./docs/docker-aws.md)
- [Deploy to Heroku](./docs/docker-heroku.md)