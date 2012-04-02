{ModelView} = require './bases/model_view'

class exports.UserView extends ModelView
  template: 'views/templates/user'
  title: ->
    "#{@object.get('login')}"
