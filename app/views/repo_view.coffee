{ModelView} = require './bases/model_view'

class exports.RepoView extends ModelView
  template: 'views/templates/repo'
  title: ->
    "#{@object.get('owner').login}/#{@object.get('name')}"
