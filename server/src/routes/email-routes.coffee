feature = require '../feature-toggles'
sendgrid = require('sendgrid')('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')
Q = require 'q'

module.exports = (router) ->

  router.post '/contact/mail', (next) ->
    {name, phone, email, message} = @request.body

    yield Q.ninvoke sendgrid, 'send',
      to:       'jacob@foosnet.io'
      from:     'donotreply@foosnet.io'
      subject:  'Marketting "contact us" message'
      text:     "name: #{name}\nemail: #{email}\nmessage:\n#{message}"
    .then (res) =>
      @status = 204
    .catch (err) =>
      @status 500
