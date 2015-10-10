class Geolocator
  settings:
    maximumAge: 3000
    timeout: 5000
    enableHighAccuracy: true

  getLocation: ->
    deferred = Q.defer()

    successCallback = (position)->
        latitude = position.coords.latitude
        longitude = position.coords.longitude
        deferred.resolve position

    errorCallback = (error)-> deferred.reject(error)

    navigator.geolocation.getCurrentPosition successCallback, errorCallback, @settings

    deferred.promise

  watchLocation: ->
    successCallback = (position) ->
      Schnauze.EventEmitter.emit 'Geolocation:locationChange', position

    errorCallback = (error) ->
      Schnauze.EventEmitter.emit 'Geolocation:locationChangeError', error

    navigator.geolocation.watchPosition successCallback, errorCallback, @settings

Schnauze.Utils.Geolocator = new Geolocator