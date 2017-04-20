## Heroku Deploy

If you want to deploy your app using [Heroku](https://www.heroku.com) you need to do the following:

- Add the Heroku Git URL to your remotes
- Push to heroku

```bash
	git remote add heroku-prod your-git-url
	git push heroku-prod your-branch:master
```

### SSL

- [Heroku SSL Certificate](http://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku/)
