# Environment
# ==================================

UI.registerHelper 'isCordova', () ->
  return true if Meteor.isCordova

UI.registerHelper 'isAndroid', () ->
  return true if Meteor.isCordova and cordova.platformId is "android"

UI.registerHelper 'isIos', () ->
  return true if Meteor.isCordova and cordova.platformId is "ios"


# Date helper
# ==================================

UI.registerHelper "formatDate", (datetime, format) ->
  return moment(datetime).fromNow() if format is 'fromNow'
  moment(datetime).format format