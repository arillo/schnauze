Template.list.onCreated () ->
  Meteor.subscribe 'audioSnippets'
  self = @
  self.selectedItem = new ReactiveVar 0
  #console.log window.WaveSurfer

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({})
  

# Template.list.events
#   'click .js-listItem': (e, t) ->
#     t.selectedItem.set 
    # $el = $(e.target).closest('.js-listItem').parent()
    # e.stopImmediatePropagation()
    # if $el.hasClass 'is-playing'
    #   $el.removeClass 'is-playing'
    # else
    #   $el.addClass 'is-playing'

