{NotifyRequest} = require '../models'
feature = require '../feature-toggles'
Q = require 'q'

module.exports = (router) ->

  renderApp = ->
    if @passport.user
      @body = yield @render 'application/index',
        session:
          user: @passport.user
    else if feature.isEnabled 'launch'
      @body = yield @render 'marketing/index'
    else
      @body = yield @render 'marketing/splash'

  router.get '/', renderApp
  router.get '/leagues', renderApp
  router.get '/leaderboard', renderApp

  router.get '/login', (next) ->
    if @passport.user
      @body = yield @render 'application/index',
        session:
          user: @passport.user
    else
      @body = yield @render 'marketing/login'

  router.post '/notify', ->
    {name, email} = @request.body

    @body = yield Q.ninvoke NotifyRequest, 'findOneAndUpdate', {email}, {name, email}, upsert: true
    .then =>
      @status = 204
    .catch (err) =>
      @status = 500
      err
