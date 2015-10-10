Meteor.startup () ->
  GoogleMaps.load()

Template.map.helpers
  mapOptions: () ->
    # Make sure the maps API has loaded
    if GoogleMaps.loaded()
      # Map initialization options
      return {
        center: new google.maps.LatLng(52.5123008, 13.4460634)
        zoom: 15
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

    Schnauze.EventEmitter.on 'Geolocator:positionChange', (position) ->
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      marker.setPosition center

    Schnauze.Geolocator.getPosition().then (position) ->
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      map.instance.setCenter center