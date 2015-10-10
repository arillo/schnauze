styles = [
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#193341"
      }
    ]
  },
  {
    "featureType": "landscape",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c5a71"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#29768a"
      },
      {
        "lightness": -37
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#406d80"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#406d80"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "visibility": "on"
      },
      {
        "color": "#3e606f"
      },
      {
        "weight": 2
      },
      {
        "gamma": 0.84
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "weight": 0.6
      },
      {
        "color": "#1a3541"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c5a71"
      }
    ]
  }
]


Template.map.helpers
  mapOptions: () ->
    # Make sure the maps API has loaded
    if GoogleMaps.loaded()
      # Map initialization options
      return {
        center: new google.maps.LatLng(52.5123008, 13.4460634)
        zoom: 8
        disableDefaultUI: true
        styles: styles
      }

Template.map.onCreated () ->
  # We can use the `ready` callback to interact with the map API once the map is ready.
  GoogleMaps.ready 'map', (map) ->
    # Add a marker to the map once it's ready
    marker = new google.maps.Marker {
      position: map.options.center
      map: map.instance
    }