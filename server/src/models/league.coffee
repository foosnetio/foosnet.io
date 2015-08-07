mongoose = require 'mongoose'

schema = mongoose.Schema
  name: String
  location: String
  players: [
    type: mongoose.Schema.Types.ObjectId
    ref: 'User'
  ]

module.exports = mongoose.model 'League', schema
