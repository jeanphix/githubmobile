loaderTemplate = require 'views/templates/loader'
backTemplate = require 'views/templates/back'

# Base class for all views that deal with a remote object.
class exports.BaseView extends Backbone.View
  events:
    'click section > section *[href]': 'onLinkClick'
    'click .back': '_back'
  tagName: 'section'
  title: 'view title'
  baseTemplate: 'views/templates/bases/base'
  template: null
  objectClass: null
  endpoint: null

  # Initializes the object, then appends @$el to the application views holder.
  initialize: ->
    @baseTemplate = require @baseTemplate
    @template = require @template
    @object = new @objectClass
    $('body > section > div').append(@$el)

  # Renders the template with appropriate context.
  render: ->
    @$el.html @_renderTemplate @context()
    @scroll = new iScroll @$el.children('section').get(0)
    if app._viewsStack.length > 1
      @$el.find('header h1').before backTemplate()

  # Refreshes the remote object for given (or previous) endpoint.
  refresh: (endpoint) ->
    @currentEndpoint = if endpoint then endpoint else @endpoint
    @currentEndpoint = @currentEndpoint() if typeof @currentEndpoint == 'function'
    @object.url = app.apiUrl(@currentEndpoint)
    @object.fetch
      success: (model, response) =>
        @trigger 'refresh:success', model, response
      error: (model, reponse) =>
        @trigger 'refresh:error', model, response

  # Returns the view context as an object.
  context: ->
    {}

  # Displays a gif loader
  showLoader: ->
    @$el.find('header h1').after loaderTemplate()

  # Hides the gif loader.
  hideLoader: ->
    @$el.find('.loader').remove()

  # Destroys the html element @$el.
  destroy: ->
    @$el.remove()

  # Navigates to the appropriate endpoint.
  onLinkClick: (e) ->
    e.preventDefault()
    app.router.navigate app.endpoint($(e.currentTarget).attr 'href'), trigger: true

  # Renders the template as `content` of baseTemplate
  _renderTemplate: ->
    title = if typeof @title == 'function' then @title() else @title
    content = @template @context()
    @baseTemplate title: title, content: content

  # Triggers a `back` event when the back link is clicked.
  _back: (e) ->
    @trigger 'back'
    e.preventDefault()

