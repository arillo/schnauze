Schnauze.EventEmitter.on 'Recorder:stopRecording', (payload) ->
    console.log '[EventEmitter::on] -> Recorder:stopRecording', payload
    Schnauze.Collections.AudioSnippets.insert payload.file, (err, fileObj) ->
        console.log(err, fileObj)