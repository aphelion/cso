# CSO

[![Circle CI](https://circleci.com/gh/aphelion/cso.svg?style=svg)](https://circleci.com/gh/aphelion/cso)

## Heroku Configuration

Add config vars

```
heroku config:add FACEBOOK_KEY='YOUR_FACEBOOK_KEY'
heroku config:add FACEBOOK_SECRET='YOUR_FACEBOOK_SECRET'
heroku config:add GOOGLE_KEY='YOUR_GOOGLE_KEY'
heroku config:add GOOGLE_SECRET='YOUR_GOOGLE_SECRET'
heroku config:add STRIPE_PUBLISHABLE_KEY='YOUR_STRIPE_PUBLISHABLE_KEY'
heroku config:add STRIPE_SECRET_KEY='YOUR_STRIPE_SECRET_KEY'
```

Provision an admin

```
heroku pg:psql -c "UPDATE users SET admin = true WHERE email = 'EMAIL_ADDRESS'"
```
