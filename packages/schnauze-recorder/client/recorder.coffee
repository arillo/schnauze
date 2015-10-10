AUDIO_DURATION = 30

class Recorder

  record: () ->
    console.log 'start recording'
    window.plugins.audioRecorderAPI.record ((msg) ->
      console.log '[recorder:record] success', msg
      return
    ), ((msg) ->
      console.log '[recorder:record] error', msg
      return
    ), AUDIO_DURATION
    return

  stop: () ->
    window.plugins.audioRecorderAPI.stop ((msg) ->
      console.log '[recorder:stop] success', msg
      
      window.resolveLocalFileSystemURL 'file://' + msg, ((res) ->
        console.log '[recorder:resolveLocalFileSystemURL] success', msg
        res.file ((file) ->
          
          Schnauze.EventEmitter.emit 'Recorder:stopRecording',
            file: file

          console.log '[recorder:file] success', file
          return
        ), (err) ->
          console.log '[recorder:file] err', err
          return
        return
      ), (err) ->
        console.log '[recorder:resolveLocalFileSystemURL] error', err
        return
      return

      return
    ), ((msg) ->
      console.log '[recorder:stop] error', msg
      return
    ), AUDIO_DURATION
    return

  playback: () ->
    window.plugins.audioRecorderAPI.playback ((msg) ->
      console.log '[recorder:playback] success', msg
      return
    ), ((msg) ->
      console.log '[recorder:playback] error', msg
      return
    ), AUDIO_DURATION
    return

Schnauze.EventEmitter.on 'Recorder:startRecording', ->
  Schnauze.Recorder.record()

Schnauze.Recorder = new Recorder
