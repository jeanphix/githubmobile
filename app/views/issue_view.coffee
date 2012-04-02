{ModelView} = require './bases/model_view'

class exports.IssueView extends ModelView
  template: 'views/templates/issue'
  title: ->
    "issue ##{@object.get('number')}"
