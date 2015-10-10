Template.list.onCreated () ->
  Meteor.subscribe 'audioSnippets'
  #console.log window.WaveSurfer

Template.list.helpers
  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({})