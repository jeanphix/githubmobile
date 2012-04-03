{CollectionView} = require 'views/bases/collection_view'

class exports.UsersView extends CollectionView
  title: 'users'
  itemTemplate: 'views/templates/user_item'
