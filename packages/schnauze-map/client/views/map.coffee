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

Template.map.onCreated () ->
  # We can use the `ready` callback to interact with the map API once the map is ready.
  GoogleMaps.ready 'map', (map) ->
    # Add a marker to the map once it's ready
    marker = new google.maps.Marker {
      position: map.options.center
      map: map.instance
      icon: 'images/map-position.svg'
    }

    radius = new google.maps.Circle
      map: map.instance
      radius: Schnauze.Settings.map.radiusMeters
      fillColor: '#d32f2f'
      strokeWeight: 0

    radius.bindTo 'center', marker, 'position'

    Schnauze.EventEmitter.on 'Geolocator:positionChange', (position) ->
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      marker.setPosition center

    centerMap = ->
      Schnauze.Geolocator.getPosition()
        .then (position) ->
          center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
          map.instance.setCenter center
          marker.setPosition center
          
          mapBounds = map.instance.getBounds()
          bottomLeft = mapBounds.getSouthWest()
          topRight = mapBounds.getNorthEast()
          
          mapBoundsSession = 
            bottomLeft: [bottomLeft.lng(), bottomLeft.lat()]
            topRight: [topRight.lng(), topRight.lat()]
          
          console.log mapBoundsSession

          Session.set 'Schnauze.Map:bounds', mapBoundsSession

        .catch (error) ->
          console.log 'Error - centerMap', error

    # center map once on startup
    centerMap()

    Schnauze.EventEmitter.on 'Menu:toggleList', ->
      setTimeout ->
        google.maps.event.trigger map.instance, 'resize'
        centerMap()
      , 200

    Schnauze.EventEmitter.on 'Menu:centerMap', centerMap