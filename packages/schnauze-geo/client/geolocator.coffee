class Geolocator
  settings: Schnauze.Settings.geolocation

  getPosition: ->
    deferred = Q.defer()

    successCallback = (position)->
      Session.set 'Schnauze.Geolocator:currentPosition', [position.coords.longitude, position.coords.latitude]
      deferred.resolve position

    errorCallback = (error)->
      deferred.reject error

    navigator.geolocation.getCurrentPosition successCallback, errorCallback, @settings

    deferred.promise

  watchPosition: ->
    successCallback = (position) ->
      Schnauze.EventEmitter.emit 'Geolocator:positionChange', position
      Session.set 'Schnauze.Geolocator:currentPosition', [position.coords.longitude, position.coords.latitude]
    
    errorCallback = (error) ->
      Schnauze.EventEmitter.emit 'Geolocator:positionChangeError', error

    navigator.geolocation.watchPosition successCallback, errorCallback, @settings

Schnauze.Geolocator = geolocator = new Geolocator

geolocator.getPosition()
  .then ->
    geolocator.watchPosition()
    Session.set 'Schnauze.Error:geolocation', null
  .catch ->
    Schnauze.EventEmitter.emit 'Geolocator:positionChangeError', error
