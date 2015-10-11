Template.list.onCreated () ->
  self = @
  self.selectedItem = new ReactiveVar 0

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({ inRadius: yes }, {sort: uploadedAt: -1})