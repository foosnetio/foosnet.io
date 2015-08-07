
module.exports = (router) ->
  require('./api') router
  require('./application-routes') router
  require('./auth-routes') router
  require('./email-routes') router
