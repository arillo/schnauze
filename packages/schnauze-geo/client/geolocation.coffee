###
#
# Geolocation setup
#
# Listen to geolocation changes and trigger event
###

# settings
GeolocationSettings =
  timeout: 5000
  maximumAge: 3000
  enableHighAccuracy: yes

GeolocationSuccess = (location) ->
  console.log 'location', location.coords
  Schnauze.EventEmitter.emit 'Geolocation:locationChange',
    coords: location.coords

GeolocationError = (error) ->
  Schnauze.EventEmitter.emit 'Geolocation:error', error

# start watching for location changes
navigator.geolocation.watchPosition GeolocationSuccess, GeolocationError, GeolocationSettings