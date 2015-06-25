mongoose = require 'mongoose'

schema = mongoose.Schema
  name: String
  email: String

module.exports = mongoose.model 'NotifyRequest', schema
