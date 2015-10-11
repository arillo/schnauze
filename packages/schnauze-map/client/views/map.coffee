Meteor.startup () ->
  GoogleMaps.load()

Template.map.helpers
  mapOptions: () ->
    # Make sure the maps API has loaded
    if GoogleMaps.loaded()
      # Map initialization options
      return {
        center: new google.maps.LatLng(0, 0)
        zoom: 14
        disableDefaultUI: true
        styles: Schnauze.Utils.MapStyles
      }

createMarker = (doc, markers, map) ->
  coords = doc.metadata.loc.coordinates
  markers[doc._id] = new google.maps.Marker {
      position: new google.maps.LatLng(coords[1], coords[0])
      map: map.instance
      icon: 'images/map-marker.svg'
    }
  markers[doc._id].addListener 'click', () ->
    Schnauze.EventEmitter.emit 'Marker:openAudio', 
      id: doc._id

moveMarker = (doc, markers) ->
  coords = doc.metadata.loc.coordinates
  marker = markers[doc._id]
  if marker?
    marker.setPosition(new google.maps.LatLng(coords[1], coords[0]))

removeMarker = (doc, markers) ->
  marker = markers[doc._id]
  if marker?
    marker.setMap null
    delete marker[doc._id]

updateMapBounds = (map) ->
  mapBounds = map.instance.getBounds()
  bottomLeft = mapBounds.getSouthWest()
  topRight = mapBounds.getNorthEast()
  
  mapBoundsSession = 
    bottomLeft: [bottomLeft.lng(), bottomLeft.lat()]
    topRight: [topRight.lng(), topRight.lat()]
  Session.set 'Schnauze.Map:bounds', mapBoundsSession

listenUpdateMapBounds = (map) ->
  map.instance.addListener 'zoom_changed', ->
    updateMapBounds map

  map.instance.addListener 'bounds_changed', ->
    updateMapBounds map

renderRadius = (map, marker) ->
  radius = new google.maps.Circle
    map: map.instance
    radius: Schnauze.Settings.map.radiusMeters
    fillColor: '#d32f2f'
    strokeWeight: 0

  radius.bindTo 'center', marker, 'position'

updateMarkers = (map, markers)->
  Schnauze.Collections.AudioSnippets.find().observe
    added: (doc) ->
      createMarker doc, markers, map
    changed: (newDoc, oldDoc) ->
      moveMarker newDoc, markers
    removed: (oldDoc) ->
      removeMarker oldDoc, markers

centerMap = (map, marker)->
  Schnauze.Geolocator.getPosition()
    .then (position) ->
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      map.instance.setCenter center
      marker.setPosition center
      updateMapBounds map
    .catch (error) ->
      console.log 'Error - centerMap', error

onMapReady = (map) ->
  markers = {}

  # Add a marker to the map once it's ready
  marker = new google.maps.Marker {
    position: map.options.center
    map: map.instance
    icon: 'images/map-position.svg'
  }

  renderRadius map, marker
  listenUpdateMapBounds map
  updateMarkers map, markers
  centerMap map, marker

  Schnauze.EventEmitter.on 'Geolocator:positionChange', (position) ->
    center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    marker.setPosition center

  Schnauze.EventEmitter.on 'Menu:toggleList', ->
    setTimeout ->
      google.maps.event.trigger map.instance, 'resize'
      centerMap(map, marker)
    , 200

  Schnauze.EventEmitter.on 'Menu:centerMap', ->
    centerMap(map, marker)

Template.map.onCreated () ->

  # We can use the `ready` callback to interact with the map API once the map is ready.
  GoogleMaps.ready 'map', onMapReady
    