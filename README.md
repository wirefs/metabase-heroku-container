## Deploy

### Automatic Deployments
Connect github repo to the pipeline and use automatic deployments based on the branch changes

### Manual Deployments
1.  Keep Docker desktop or service open
2.  `heroku container:login`
3.  `heroku container:push web --app HEROKU_APP_NAME`
4.  `heroku container:release web`

based on https://devcenter.heroku.com/articles/container-registry-and-runtime#getting-started

# Required environment variables

* DATABASE_URL=DB_URI  
* MB_DB_TYPE=postgres
