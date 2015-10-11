Meteor.publish 'audioSnippets', (mapBounds, currentPosition) ->
  console.log 'schnauze:app'.yellow, '[publication] audioSnippets'.blue, mapBounds, currentPosition
  
  selector = {}
  transform = (doc) -> doc

  # filter by bounds
  if mapBounds? and mapBounds.bottomLeft? and mapBounds.topRight?
    selector = 'metadata.loc.coordinates':
      $within:
        $box : [mapBounds.bottomLeft, mapBounds.topRight]

  # set 'inRadius' flag
  if currentPosition?
    radius = Meteor.settings.public.app.map.radiusMeters

    transform = (doc) ->
      coords = doc.metadata.loc.coordinates
      doc.inRadius = distance(coords[1], coords[0], currentPosition[1], currentPosition[0]) <= radius / 1000 # convert meters to km
      console.log doc.inRadius
      doc

  self = this

  observer = Schnauze.Collections.AudioSnippets.find(selector).observe(
    added: (doc) ->
      self.added 'audioSnippets', doc._id, transform(doc)
      return
    changed: (newDocument, oldDocument) ->
      self.changed 'audioSnippets', oldDocument._id, transform(newDocument)
      return
    removed: (oldDocument) ->
      self.removed 'audioSnippets', oldDocument._id
      return
  )

  self.onStop ->
    observer.stop()
    return
  self.ready()
  return


# helpers
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