connect = ->
  mongoose = require 'mongoose'
  connectUri = process.env.FOOSNETIO_MONGO_URI ? 'mongodb://localhost/test'

  mongoose.connect connectUri

  mongoose.connection.once 'open', ->
    console.log "Connected to MongoDB at: #{connectUri}".blue

  mongoose.connection.on 'error', (error) ->
    message = 'MongoDB error: ' + error
    console.log "MongoDB error: #{error}".red

module.exports =
  connect: connect
  League: require './league'
  NotifyRequest: require './notify-request'
  User: require './user'
