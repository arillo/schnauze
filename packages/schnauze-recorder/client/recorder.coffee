audioDuration = Schnauze.Settings.recorder.audioDurationSeconds

class Recorder

  desktop: false

  record: () ->
    return if @desktop
    window.plugins.audioRecorderAPI.record ((msg) ->
      return
    ), ((msg) ->
      console.log '[recorder:record] error', msg
      return
    ), audioDuration
    return

  stop: () ->
    return if @desktop

    self = @
    window.plugins.audioRecorderAPI.stop ((msg) ->
      window.resolveLocalFileSystemURL 'file://' + msg, self.onResolveLocalFileSystemSuccess, self.onResolveLocalFileSystemError
      return
    ), ((msg) ->
      console.log '[recorder:stop] error', msg
      return
    ), audioDuration
    return

  playback: () ->
    return if @desktop

    window.plugins.audioRecorderAPI.playback ((msg) ->
      return
    ), ((msg) ->
      console.log '[recorder:playback] error', msg
      return
    ), audioDuration
    return
  
  # file handling
  onResolveLocalFileSystemSuccess: (res) ->
    res.file ((file) ->
      Schnauze.EventEmitter.emit 'Recorder:stopRecording',
        file: file
      return
    ), (err) ->
      console.log '[recorder:file] err', err
      return
    return

  onResolveLocalFileSystemError: (err) ->
    console.log '[recorder:resolveLocalFileSystemURL] error', err
    return

Schnauze.Recorder = new Recorder
Schnauze.Recorder.desktop = true unless Meteor.isCordova

Meteor.startup () ->
  window.plugins.audioRecorderAPI.record ((msg) ->
    Session.set 'Schnauze.Error:recorder', null
    return
  ), ((err) ->
    console.log '[recorder:record] error', err
    Schnauze.EventEmitter.emit 'Recorder:notAllowedError', err
    return
  ), 0