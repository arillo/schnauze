if Meteor.isClient
  Meteor.startup () ->
    GoogleMaps.load()