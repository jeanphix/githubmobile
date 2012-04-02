sysPath = require 'path'
express = require 'express'
oauth = require 'oauth'


_appSecret = process.env.APP_SECRET
_githubUrl = "https://github.com/login"
_githubKey = process.env.GITHUB_KEY
_githubSecret = process.env.GITHUB_SECRET
_githubCallBack = process.env.GITHUB_CALLBACK


consumer = ->
  new oauth.OAuth2 _githubKey, _githubSecret, _githubUrl


createServer = (path) ->
  server = express.createServer()

  server.use express.cookieParser()

  server.configure ->
    server.use express.static path
    server.set 'views', path
    server.set 'view options', layout: no
    server.register '.html', compile: (str, options) -> (locals) -> str

  server.get '/', (req, res) ->
    res.render 'index.html'

  server.get '/signin', (req, res) ->
    c =  consumer()
    res.redirect(c.getAuthorizeUrl({redirect_uri: _githubCallBack, scope: 'repo'}))

  server.get '/signin/callback', (req, res) ->
    c =  consumer()
    c.getOAuthAccessToken req.query.code, null, (error, oauth_token, oauth_token_secret, results) ->
      if error
        console.log error
      else
        res.cookie "github_token", oauth_token, { path: '/' }
        res.redirect('/')

  server.get '/signout', (req, res) ->
    res.clearCookie('github_token')
    res.redirect('/')

  server


exports.startServer = (port, path, callback) ->
  server = createServer(path)
  server.listen parseInt process.env.PORT || port, 10
  server.on 'listening', callback
  console.log "application started on http://0.0.0.0:#{port}."
