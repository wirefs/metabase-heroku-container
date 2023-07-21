# metabase-docker

## Deploy
based on https://devcenter.heroku.com/articles/container-registry-and-runtime#getting-started
1.  Keep Docker desktop or service open
2. `heroku container:login`
3. `heroku container:push web --app HEROKU_APP_NAME`
4. `heroku container:release web`
