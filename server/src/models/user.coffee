mongoose = require 'mongoose'

schema = mongoose.Schema
  emails: [String]
  facebook:
    accessToken: String
    refreshToken: String
  github:
    accessToken: String
    refreshToken: String
  google:
    accessToken: String
    refreshToken: String

module.exports = mongoose.model 'User', schema
