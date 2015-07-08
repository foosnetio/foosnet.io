process.env.NODE_ENV ?= 'development'

koa = require 'koa'
router = require('koa-router')()
logger = require 'koa-bunyan-logger'
bunyanLogentries = require 'bunyan-logentries'
passport = require 'koa-passport'

require 'colors'
require('./models').connect()
require('./passport').initialize()
require('./routes') router

loggerStreams = [
  level: 'info'
  stream: bunyanLogentries.createStream token: process.env.FOOSNETIO_LOGENTRIES_TOKEN
  type: 'raw'
]

if process.env.NODE_ENV is 'development'
  PrettyStream = require 'bunyan-prettystream'
  prettyStdOut = new PrettyStream()
  prettyStdOut.pipe process.stdout

  loggerStreams.push
    level: 'debug'
    type: 'raw'
    stream: prettyStdOut

app = koa()
app.keys = [process.env.FOOSNETIO_SESSION_SECRET ? 'f00sYoMamA']
app
  .use require('koa-favicon')("#{__dirname}/../../client/dist/resources/images/favicon.ico")
  .use require('koa-static')("#{__dirname}/../../client/dist/")
  .use logger
    name: 'foosnet.io'
    level: process.env.LOG_LEVEL || 'debug'
    streams: loggerStreams
  .use logger.requestIdContext()
  .use logger.timeContext()
  .use logger.requestLogger()
  .use require('koa-bodyparser')()
  .use require('koa-render')("#{__dirname}/../views", 'jade')
  .use require('koa-generic-session')()
  .use passport.initialize()
  .use passport.session()
  .use router.routes()
  .use router.allowedMethods()

module.exports = app
