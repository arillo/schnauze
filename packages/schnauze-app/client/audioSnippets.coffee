Schnauze.EventEmitter.on 'Recorder:stopRecording', (payload) ->
  console.log '[EventEmitter::on] -> Recorder:stopRecording', payload

  Schnauze.Geolocator.getPosition().then (pos) ->
    file = new FS.File(payload.file)
    file.metadata = 
      loc: 
        type: 'Point'
        coordinates: [pos.coords.longitude, pos.coords.latitude]
            
    console.log file
    Schnauze.Collections.AudioSnippets.insert file, (err, fileObj) ->
      console.log(err, fileObj)

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

    Schnauze.Collections.AudioSnippets.update { _id: payload.audio._id }, { $set: { lifetime: newLifetime } }, (error) ->
      console.log '################# updateLifetime', error, audio._id
      Session.setPersistent('Schnauze.AudioSnippet:lifeExtended-' + audio._id, yes) if not error?

Meteor.startup () ->
  Tracker.autorun () ->
    console.log 'resubscribe audioSnippets', Session.get('Schnauze.Map:bounds'), Session.get('Schnauze.Geolocator:currentPosition')
    Meteor.subscribe 'audioSnippets', Session.get('Schnauze.Map:bounds'), Session.get('Schnauze.Geolocator:currentPosition')