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

Meteor.startup () ->
    Tracker.autorun () ->
        console.log 'resubscribe audioSnippets', Session.get('Schnauze.Map:bounds')
        Meteor.subscribe 'audioSnippets', Session.get('Schnauze.Map:bounds')