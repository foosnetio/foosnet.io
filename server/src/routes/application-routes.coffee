{NotifyRequest} = require '../models'
feature = require '../feature-toggles'
Q = require 'q'

module.exports = (router) ->

  router.get '/', (next) ->
    if @passport.user
      @body = yield @render 'application/index'
    else if feature.isEnabled 'launch'
      @body = yield @render 'marketing/index'
    else
      @body = yield @render 'marketing/splash'

  router.get '/create', (next) ->
    @body = yield @render 'marketing/create'

  router.post '/suggestUrl', (next) ->
    console.log 'here', @request.body
    @body =
      available: [@request.body.name]
      unavailable: []
    yield next

  router.get '/login', (next) ->
    if @passport.user
      @body = yield @render 'application/index'
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
