{CollectionView} = require 'views/bases/collection_view'

class exports.IssuesView extends CollectionView
  title: 'issues'
  itemTemplate: 'views/templates/issue_item'
