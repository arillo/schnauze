Template.list.onCreated () ->
    Meteor.subscribe 'audioSnippets'

Template.list.helpers
   snippets: () ->
      Schnauze.Collections.AudioSnippets.find({})