# Deploy Node app with postgres on Google App Engine

## Google cloud console

Let's start with the important things you need to know about [google cloud console](https://console.cloud.google.com/). When you first enter, you will see a dashboard which summarizes up a lot of information about your project like resources, request per seconds, storage used, and so on. The tab **activity** is specially useful when you are deploying your app, there you will see when the process of deleting and creating virtual machines for your instances.

## Menu options

In **App Engine** you will find all the information about your services, version and instances status, and you can manage traffic here. An important detail is that the default service **cannot** be deleted. Clicking your version will open your deployed service. 

In the stackdriver section, **logs** is where you should look if you wanna see what is happening in your app. A very important detail is that your deploy will stuck in an infinite loop if your app crashes, so the logs is where you will see this. Also keep in mind that you can not enter to the virtual machine where your app is, so the logs is your only window to see what is going on. 

In **sql**, your instance's information is available, including your engine, databases, users, passwords and used storage space. 

## Getting started

The first thing you need to do is to create a project with your google account. After this, you can do the following space in your local machine (installing  and setting the [Google Cloud Sdk](https://cloud.google.com/sdk/docs/quickstart-linux)) or cloning your repository in the Google Cloud Shell, which you can enter in the [google cloud console](https://console.cloud.google.com/). Another thing to do is to create an sql instance (in this case, a [postgres](https://cloud.google.com/sql/docs/postgres/create-instance) one). 


## Connecting to the database

An important thing to understand is that your sql instance and your app instance run in differents virtual machines, so google uses Google Sql Proxy to open a socket listening on localhost. This is automatically done in the deploy machine but you will have to do it manually if you want to test in the cloud shell. This [tutorial](https://cloud.google.com/appengine/docs/flexible/nodejs/using-cloud-sql-postgres) is really useful for using the proxy. 
Usually, we connect to the database using a TCP socket, but Google Sql Proxy uses unix one, so we will need to change our standard configurations a little bit.
In normal cases we use an url like 

```
postgres://username:password@host:port/database
```

And connecting with

```
Const db = new Sequelize(url, your_db_extra_config);
```

But in this case we will need to connect by specifying the host in the configuration:

 ```
 const sequelizeConfig = {
   dialect: 'postgres',
   host: YOUR_DB_NAME_HOST
 };
 const db = new Sequelize(YOUR_DB_NAME, YOUR_POSTGRES_USERNMAE, YOUR_POSTGRES_PASSWORD, sequelizeConfig);
 ```

Finally, you will need to change the authentication method in postgres. This is because TCP sockets use md5 and unix sockets use peer authentication, and we will want to authenticate with username and password as always. So, go into the google cloud shell, cd /etc/postgresql/9.x/main/pg_hba.conf, and edit this line with sudo:

```
TYPE DATABASE USER ADDRESS METHOD 
local all all peer
```

For 

```
local all all md5
```

## Deploying a NodeJS app

Before deploying your app, it is recommended to test it in the Google Cloud Shell.
In the root of your project, create a file named app.yaml. The things you must include here are: 

```
runtime: nodejs
  env: flex
```

Then, you should set your cloud sql instance:

```
beta_settings:
 cloud_sql_instances: YOUR_INSTANCE_CONNECTION_NAME
```

You can check your instance connection name in sql menu, or in your terminal using the google cloud sdk: 

```
gcloud sql instances describe [INSTANCE_NAME]
```

You should set your environment variables also in the yaml file:

```
env_variables:
 NODE_API_DB_PORT: PORT
 NODE_API_DB_NAME: DB_NAME
 NODE_API_DB_USERNAME: DB_USERNAME
 NODE_API_DB_PASSWORD: DB_PASSWORD
 NODE_API_DB_HOST: /cloudsql/INSTANCE_CONNECTION_NAME
```

For more configurations (like resource settings), visit the [official documentation](https://cloud.google.com/appengine/docs/flexible/nodejs/configuring-your-app-with-app-yaml).
If you like, you can change the steps runned in your deploying by using a [Dockerfile](https://docs.docker.com/engine/reference/builder/). Simply change the runtime to custom. Then, create your Dockerfile in the root of your project. An example for nodejs:

```
FROM gcr.io/google_appengine/nodejs
RUN apt-get update && apt-get install -y fortunes
RUN /usr/local/bin/install_node '>=6.0.0'
COPY . /app/
RUN npm install
CMD npm start
```

And finally do **gcloud app deploy** on your terminal. Notice that if you do not specify a target version with the -version flag and you have already a deployed one, it will deploy another version and keep both alive.  

A very important thing to know is that when a deploy fails, you will have to wait for that process to terminate. If you try to deploy immediately after, you will get:

```
ERROR: (gcloud.app.deploy) The requested resource already exists.
```

Usually, you have to wait 15 minutes between the deploys, and a deploy process takes about 10 minutes, but it will change depending on how many dependencies you have in your package.json. 
