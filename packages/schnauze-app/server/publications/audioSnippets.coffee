Meteor.publish 'audioSnippets', (mapBounds) ->
  console.log 'schnauze:app'.yellow, '[publication] audioSnippets'.blue
  
  selector = {}

  console.log mapBounds

  if mapBounds? and mapBounds.bottomLeft? and mapBounds.topRight?
    console.log '############### inside'
    selector = 'metadata.loc.coordinates':
      $within:
        $box : [mapBounds.bottomLeft, mapBounds.topRight]

  Schnauze.Collections.AudioSnippets.find selector