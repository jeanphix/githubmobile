{BrunchApplication} = require 'helpers'
{User} = require 'models/user'
{MainRouter} = require 'routers/main_router'
{NavigationView} = require 'views/navigation_view'

class exports.Application extends BrunchApplication
  # Initializes default members and navigation view.
  initialize: ->
    # The github API base url.
    @_githubApiBaseUrl = "https://api.github.com/"
    # The github access token.
    @_githubToken = null
    # The displayed view.
    @_currentView = null
    # The main router.
    @router = new MainRouter
    # The view stack that stores all initialized views.
    @_viewsStack = []
    # The User
    @user = new User
    # The horizontal slider
    @mslide = new mSlide 'views'
    # Listener to slider previous.
    @mslide.onPrevious = =>
      @_onPrevious()
    # The navigation view.
    @navigationView = new NavigationView
    # Fecthes the user.
    @fetchUser()

  # Fetches the user if a `github_token` is found in cookie.
  fetchUser: ->
    token = _.cookie 'github_token'
    if token
      @._githubToken = token
      @user.on 'change', =>
        @navigationView.render()
        @_currentView.refresh()
      @user.fetch()

  # Returns an absolute api URL with access token for given endpoint.
  apiUrl: (endpoint) ->
    url = "#{@_githubApiBaseUrl}#{endpoint}"
    if @_githubToken
      url = "#{url}?access_token=#{@_githubToken}"
    url

  # Extracts endpoint for given url.
  endpoint: (url) ->
    url.replace @_githubApiBaseUrl, ''

  # Initializes and adds a `viewClass` view to the `_viewsStack`.
  createView: (viewClass) ->
    if @_currentView
      @_currentView.showLoader()
    @_currentView = new viewClass
    @_currentView.on 'refresh:success', =>
        if @_viewsStack.length > 1
          @_viewsStack[@_viewsStack.length - 2].hideLoader()
        @mslide.slideNext()
    @_currentView.on 'back', =>
        @_previous()
    @_viewsStack.push @_currentView
    @mslide.refresh()
    @_currentView

  # Slides back to previous.
  _previous: ->
    if @_viewsStack.length > 1
      @mslide.slidePrevious()

  # Destroys the current view when slided back to previous.
  _onPrevious: ->
    @_currentView.destroy()
    @_viewsStack.pop()
    @_currentView = @_viewsStack[@_viewsStack.length - 1]
    @router.navigate(@_currentView.currentEndpoint)

window.app = new exports.Application
