{FeedsView} = require 'views/feeds_view'
{RepoView} = require 'views/repo_view'
{IssuesView} = require 'views/issues_view'
{IssueView} = require 'views/issue_view'
{UserView} = require 'views/user_view'
{ForkMeView} = require 'views/fork_me_view'

class exports.MainRouter extends Backbone.Router
  routes:
    '': 'news'
    'repos/:login/:name': 'repo'
    'repos/:login/:name/issues': 'issues'
    'repos/:login/:name/issues/:number': 'issue'
    'users/:login': 'user'
    '*endpoint': 'fork_me'

  # Displays the user received feeds if signed in, else public feeds.
  news: ->
    app.createView(FeedsView).refresh()

  # Displays a repository.
  repo: (login, name) ->
    app.createView(RepoView).refresh("repos/#{login}/#{name}")

  # Displays a repository.
  issues: (login, name) ->
    app.createView(IssuesView).refresh("repos/#{login}/#{name}/issues")

  # Displays repository issues.
  issue: (login, name, number) ->
    app.createView(IssueView).refresh("repos/#{login}/#{name}/issues/#{number}")

  # Displays a public user profile.
  user: (login) ->
    app.createView(UserView).refresh("users/#{login}")

  # Displays a fork me view for not implemented endpoints.
  fork_me: (endpoint) ->
    app.createView(ForkMeView).refresh("#{endpoint}")
