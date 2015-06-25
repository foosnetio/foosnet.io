{NotifyRequest} = require '../models'
Q = require 'q'

module.exports = (router) ->

  router.get '/', (next) ->
    if @passport.user
      @body = yield @render 'application/index'
    else
      @body = yield @render 'marketing/index'

  router.post '/notify', ->
    {name, email} = @request.body

    @body = yield Q.ninvoke NotifyRequest, 'findOneAndUpdate', {email}, {name, email}, upsert: true
    .then =>
      @status = 204
    .catch (err) =>
      @status = 500
      err
