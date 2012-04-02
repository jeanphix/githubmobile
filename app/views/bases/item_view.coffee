class exports.ItemView extends Backbone.View
  tagName: 'li'

  initialize: (model, el, template) ->
    @model = model
    @template = require template
    if model.get 'url'
        @$el.attr 'href', model.get 'url'
    @render el

  render: (el) ->
    el.append @$el.html @template model: @model.toJSON()
