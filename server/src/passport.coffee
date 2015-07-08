passport = require 'koa-passport'
request = require 'request'
_ = require 'lodash'
Q = require 'q'
{User} = require './models'

module.exports =
  initialize: ->
    passport.serializeUser (user, done) ->
      done null, user

    passport.deserializeUser (user, done) ->
      done null, user

    if process.env.NODE_ENV is 'production'
      baseUri = 'https://foosnet.io'
    else
      baseUri = "http://localhost:#{process.env.PORT}"

    authenticateUser = (provider) ->
      (accessToken, refreshToken, profile, done) ->
        emails = _.pluck profile.emails, 'value'

        Q.ninvoke User, 'findOne', emails: $in: emails
        .then (user) ->
          user ?= new User

          user[provider] = {accessToken, refreshToken}
          for email in emails
            user.emails.addToSet email

          Q.ninvoke user, 'save'
        .then (user) ->
          done null, user
        .catch done
        .done()

    GitHubStrategy = require('passport-github').Strategy
    passport.use new GitHubStrategy
      callbackURL: "#{baseUri}/auth/github/callback"
      clientID: process.env.FOOSNETIO_GITHUB_CLIENT_ID
      clientSecret: process.env.FOOSNETIO_GITHUB_CLIENT_SECRET
    , authenticateUser 'github'

    GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
    passport.use new GoogleStrategy
      callbackURL: "#{baseUri}/auth/google/callback"
      clientID: process.env.FOOSNETIO_GOOGLE_CLIENT_ID
      clientSecret: process.env.FOOSNETIO_GOOGLE_CLIENT_SECRET
    , authenticateUser 'google'

    FacebookStrategy = require('passport-facebook').Strategy
    passport.use new FacebookStrategy
      clientID: process.env.FOOSNETIO_FACEBOOK_APP_ID
      clientSecret: process.env.FOOSNETIO_FACEBOOK_APP_SECRET
      callbackURL: "#{baseUri}/auth/facebook/callback"
    , authenticateUser 'facebook'
