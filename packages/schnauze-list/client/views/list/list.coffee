Template.list.onCreated () ->
  self = @
  self.selectedItem = new ReactiveVar 0

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    options = {}
    currentPosition = Session.get 'Schnauze.Geolocator:currentPosition'

    if currentPosition?
      radius = Meteor.settings.public.app.map.radiusMeters
      
      options =
        transform: (doc) ->
          coords = doc.metadata.loc.coordinates
          doc.inRange = distance(coords[1], coords[0], currentPosition[1], currentPosition[0]) <= radius / 1000 # km
          doc
        
        sort: uploadedAt: -1

    Schnauze.Collections.AudioSnippets.find({}, options)


distance = (lat1, lon1, lat2, lon2) ->
  R = 6371
  # Radius of the earth in km
  dLat = deg2rad(lat2 - lat1)
  # deg2rad below
  dLon = deg2rad(lon2 - lon1)
  a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon / 2) * Math.sin(dLon / 2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  d = R * c
  # Distance in km
  d

deg2rad = (deg) ->
  deg * Math.PI / 180