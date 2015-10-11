Schnauze.EventEmitter.on 'Recorder:stopRecording', (payload) ->
  Schnauze.Geolocator.getPosition().then (pos) ->
    file = new FS.File(payload.file)
    file.playCount = 0
    file.lifetime = Schnauze.Settings.audioSnippets.defaultLifetimeMinutes
    file.metadata = 
      loc: 
        type: 'Point'
        coordinates: [pos.coords.longitude, pos.coords.latitude]
    Schnauze.Collections.AudioSnippets.insert file, (err, fileObj) ->
      # @TODO: fix this
      Meteor.setTimeout () ->
        Schnauze.EventEmitter.emit 'Marker:openAudio', 
          id: fileObj._id
      , 1000

Schnauze.EventEmitter.on 'ListItem:openPlayAudio', (payload) ->
  audio = payload.audio
  
  if audio?
    Schnauze.Collections.AudioSnippets.update { _id: payload.audio._id }, { $inc: { playCount: 1 } }

Schnauze.EventEmitter.on 'ListItem:extendLife', (payload) ->
  Schnauze.Collections.AudioSnippets.update { _id: payload.id }, { $set: { lifetime: payload.newLifetime } }
  Session.setPersistent('Schnauze.AudioSnippet:lifeExtended-' + payload.id, yes)

Meteor.startup () ->
  Tracker.autorun () ->
    Meteor.subscribe 'audioSnippets', Session.get('Schnauze.Map:bounds'), Session.get('Schnauze.Geolocator:currentPosition')