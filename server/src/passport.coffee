passport = require 'koa-passport'

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

    GitHubStrategy = require('passport-github').Strategy
    passport.use new GitHubStrategy
      callbackURL: "#{baseUri}/auth/github/callback"
      clientID: process.env.FOOSNET_GITHUB_CLIENT_ID
      clientSecret: process.env.FOOSNET_GITHUB_CLIENT_SECRET
    ,
      (accessToken, refreshToken, profile, done) ->
        done null, profile

    GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
    passport.use new GoogleStrategy
      callbackURL: "#{baseUri}/auth/google/callback"
      clientID: process.env.FOOSNET_GOOGLE_CLIENT_ID
      clientSecret: process.env.FOOSNET_GOOGLE_CLIENT_SECRET
    ,
      (accessToken, refreshToken, profile, done) ->
        done null, profile

    FacebookStrategy = require('passport-facebook').Strategy
    passport.use new FacebookStrategy
      clientID: process.env.FOOSNET_FACEBOOK_APP_ID
      clientSecret: process.env.FOOSNET_FACEBOOK_APP_SECRET
      callbackURL: "#{baseUri}/auth/facebook/callback"
    ,
      (accessToken, refreshToken, profile, done) ->
        done null, profile
