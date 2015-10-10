Template.list.onCreated () ->
  Meteor.subscribe 'audioSnippets'
  self = @
  self.selectedItem = new ReactiveVar 0

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({},{sort: uploadedAt: -1})