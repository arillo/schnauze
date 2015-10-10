###
#
# Geolocation setup
#
# Listen to geolocation changes and trigger event
###

# settings
GeolocationSettings =
  updateInterval: 30000
  maximumAge: 3000
  enableHighAccuracy: yes

GeolocationCallback = (location) ->
  EventEmitter.emit 'Geolocation:locationChange', location

# start watching for location changes
GeolocationFG.watch GeolocationCallback, GeolocationSettings.updateInterval,
  maximumAge: GeolocationSettings.maximumAge,
  enableHighAccuracy: GeolocationSettings.enableHighAccuracy
