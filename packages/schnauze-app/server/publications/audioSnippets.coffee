Meteor.publish 'audioSnippets', (mapBounds) ->
  console.log 'schnauze:app'.yellow, '[publication] audioSnippets'.blue, mapBounds
  
  selector = {}

  if mapBounds? and mapBounds.bottomLeft? and mapBounds.topRight?
    selector = 'metadata.loc.coordinates':
      $within:
        $box : [mapBounds.bottomLeft, mapBounds.topRight]

  Schnauze.Collections.AudioSnippets.find selector
    
