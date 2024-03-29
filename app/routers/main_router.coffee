{FeedsView} = require 'views/feeds_view'
{RepoView} = require 'views/repo_view'
{IssuesView} = require 'views/issues_view'
{IssueView} = require 'views/issue_view'
{UserView} = require 'views/user_view'
{ReposView} = require 'views/repos_view'
{UsersView} = require 'views/users_view'
{ForkMeView} = require 'views/fork_me_view'

class exports.MainRouter extends Backbone.Router
  routes:
    '': 'news'
    'repos/:login/:name': 'repo'
    'repos/:login/:name/issues': 'issues'
    'repos/:login/:name/issues/:number': 'issue'
    'repos/:login/:name/forks': 'forks'
    'repos/:login/:name/watchers': 'watchers'
    'users/:login': 'user'
    'users/:login/repos': 'user_repos'
    '*endpoint': 'fork_me'

  # Displays the user received feeds if signed in, else public feeds.
  news: ->
    app.createView(FeedsView).refresh()

  # Displays a repository.
  repo: (login, name) ->
    app.createView(RepoView).refresh("repos/#{login}/#{name}")

  # Displays repository opened issues.
  issues: (login, name) ->
    app.createView(IssuesView, "#{name}'s issues").refresh("repos/#{login}/#{name}/issues")

  # Displays a single repository issue.
  issue: (login, name, number) ->
    app.createView(IssueView, "issue ##{number}").refresh("repos/#{login}/#{name}/issues/#{number}")

  # Displays repository forks.
  forks: (login, name) ->
    app.createView(ReposView, "#{name}'s forks").refresh("repos/#{login}/#{name}/forks")

  # Displays repository watchers.
  watchers: (login, name) ->
    app.createView(UsersView, "#{name}'s watchers").refresh("repos/#{login}/#{name}/watchers")

  # Displays a public user profile.
  user: (login) ->
    app.createView(UserView).refresh("users/#{login}")

  # Displays user repositories.
  user_repos: (login) ->
    app.createView(ReposView, "#{login}'s repos").refresh("users/#{login}/repos")

  # Displays a fork me view for not implemented endpoints.
  fork_me: (endpoint) ->
    app.createView(ForkMeView).refresh("#{endpoint}")
