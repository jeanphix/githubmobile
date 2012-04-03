{CollectionView} = require 'views/bases/collection_view'

class exports.FeedsView extends CollectionView
  title: 'feeds'
  itemTemplate: 'views/templates/feed_item'
  endpoint: ->
    if app.user and app.user.get 'login'
      "users/#{app.user.get 'login'}/received_events"
    else
      'events'
