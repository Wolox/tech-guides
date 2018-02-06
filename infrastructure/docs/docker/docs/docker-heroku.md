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
