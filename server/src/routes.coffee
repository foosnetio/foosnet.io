
module.exports = (router) ->
  require('./routes/application-routes') router
  require('./routes/auth-routes') router
  require('./routes/email-routes') router
