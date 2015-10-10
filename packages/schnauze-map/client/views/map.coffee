Meteor.startup () ->
  GoogleMaps.load({key: "AIzaSyAwrfqcJ8y-S5uPZ4dwtTGd8uTCxp-CEeI"})

Template.map.helpers
  mapOptions: () ->
    # Make sure the maps API has loaded
    if GoogleMaps.loaded()
      # Map initialization options
      return {
        center: new google.maps.LatLng(52.5123008, 13.4460634)
        zoom: 8
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
    }

    # Schnauze.EventEmitter.on 'Geolocator:positionChange', (position) ->
    #   setMapCenter map.instance, marker, position

    Schnauze.Geolocator.getPosition().then (position) ->
      setMapCenter map.instance, marker, position

setMapCenter: (map, marker, position) ->
  center = new google.maps.LatLng(position.coords.longitude, position.coords.latitude)
  map.setCenter center
  marker.setPosition center