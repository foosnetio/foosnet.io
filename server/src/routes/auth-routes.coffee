passport = require 'koa-passport'

module.exports = (router) ->
  router.post '/logout', (next) ->
    @logout()
    yield next
    @redirect '/'

  router.post('/auth/github',
    passport.authenticate('github',
      scope: 'user,user:email'))
  router.get('/auth/github/callback',
    passport.authenticate('github',
      successRedirect: '/'
      failureRedirect: '/login'))

  router.post('/auth/google',
    passport.authenticate('google',
      scope: 'https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/userinfo.email'))
  router.get('/auth/google/callback',
    passport.authenticate('google',
      successRedirect: '/'
      failureRedirect: '/login'))

  router.post('/auth/facebook',
    passport.authenticate('facebook',
      scope: 'public_profile,email'))
  router.get('/auth/facebook/callback',
    passport.authenticate('facebook',
      successRedirect: '/'
      failureRedirect: '/login'))
