{League} = require '../../models'
Q = require 'q'

module.exports = (router) ->
  router.get '/api/leagues', (next) ->
    @body = yield Q.ninvoke League, 'find'

  router.get '/api/user/:userId/leagues', (next) ->
    @body = yield Q.ninvoke League, 'find', players: @params.userId

  router.post '/api/leagues', (next) ->
    unless @passport.user
      @status = 401
      return

    data = {name, location} = @request.body
    data.players = [@passport.user]

    @body = yield Q.ninvoke League, 'create', data
