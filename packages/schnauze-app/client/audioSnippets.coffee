Schnauze.EventEmitter.on 'Recorder:stopRecording', (payload) ->
  Schnauze.Geolocator.getPosition().then (pos) ->
    file = new FS.File(payload.file)
    file.metadata = 
      loc: 
        type: 'Point'
        coordinates: [pos.coords.longitude, pos.coords.latitude]
    Schnauze.Collections.AudioSnippets.insert file, (err, fileObj) ->

Schnauze.EventEmitter.on 'ListItem:openPlayAudio', (payload) ->
  audio = payload.audio
  
  if audio?
    Schnauze.Collections.AudioSnippets.update { _id: payload.audio._id }, { $inc: { playCount: 1 } }

Schnauze.EventEmitter.on 'ListItem:extendLife', (payload) ->
  audio = payload.audio
  
  if audio?
    settings = Schnauze.Settings.audioSnippets
    lifetime = audio.lifetime or settings.defaultLifetimeMinutes
    newLifetime = lifetime + settings.extendLifetimeMinutes

    return if newLifetime is settings.maxLifetimeMinutes

    Schnauze.Collections.AudioSnippets.update { _id: payload.audio._id }, { $set: { lifetime: newLifetime } }

Meteor.startup () ->
  Tracker.autorun () ->
    Meteor.subscribe 'audioSnippets', Session.get('Schnauze.Map:bounds'), Session.get('Schnauze.Geolocator:currentPosition')