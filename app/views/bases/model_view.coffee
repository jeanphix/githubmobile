{BaseView} = require './base_view'

# Base class for views that deal with a model.
class exports.ModelView extends BaseView
  objectClass: Backbone.Model

  # Initializes listeners.
  initialize: ->
    super
    @on 'refresh:success', (model, response) ->
      @onRefreshSuccess(model, response)

  # Renders @ when the model is refreshed.
  onRefreshSuccess: ->
    @render()

  # Appends the model to the context.
  context: ->
    c = super
    c.model = @object.toJSON()
    c
