Template.Recorder.events
  'click .js-record': (e, t) ->
    Schnauze.EventEmitter.emit 'Recorder:startRecording'
