template = require './templates/navigation'

class exports.NavigationView extends Backbone.View
  events:
    'click .profile': 'onProfileLinkClick'
  el: 'footer'

  initialize: ->
    @render()

  render: ->
    @$el.html template user: app.user.toJSON()

  onProfileLinkClick: (e) ->
    e.preventDefault()
    app.router.navigate app.endpoint($(e.currentTarget).attr 'href'), trigger: true
