class exports.User extends Backbone.Model
  url: ->
    app.apiUrl 'user'
