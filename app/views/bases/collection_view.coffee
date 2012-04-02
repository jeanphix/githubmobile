{BaseView} = require './base_view'
{ItemView} = require './item_view'

# Base class for views that deal with a remote collection.
class exports.CollectionView extends BaseView
  template: 'views/templates/bases/collection'
  # Sets the path to item template
  itemTemplate: null
  itemViewClass: ItemView
  objectClass: Backbone.Collection
  listEl: 'ul'

  # Initializes listeners.
  initialize: ->
    super
    @on 'refresh:success', (model, response) ->
      @onRefreshSuccess(model, response)
    @render()

  # Renders the models when collection is refreshed.
  onRefreshSuccess: (object, response) ->
    @renderItems object.models
    @scroll.refresh()

  # Initializes a view for each given model.
  renderItems: (models) ->
    listEl = @$el.find(@listEl)
    @itemViews = (new @itemViewClass model, listEl, @itemTemplate for model in models)
