Template.Recorder.helpers
  isRecording: ->
    Session.get('Schnauze.Recorder:isRecording')


Template.Recorder.events
  'touchend .js-recorder': (e, t) ->
    Schnauze.EventEmitter.emit 'Recorder:startRecording'
  'touchend .js-recorder': (e, t) ->
    Schnauze.EventEmitter.emit 'Recorder:startRecording'

  ###
  # DEV
  'click .js-recorder': (e, t) ->
    Schnauze.EventEmitter.emit 'Recorder:startRecording'
  ###