Meteor.publish 'audioSnippets', (mapBounds) ->
  console.log 'schnauze:app'.yellow, '[publication] audioSnippets'.blue
  
  selector = {}

  if mapBounds? and mapBounds.bottomLeft? and mapBounds.topRight?
    selector = 'loc.coordinates':
      $geoWithin:
        $box : [mapBounds.bottomLeft, mapBounds.topRight]

  Schnauze.Collections.AudioSnippets.find selector