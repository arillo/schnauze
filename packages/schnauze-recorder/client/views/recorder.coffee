Template.recorder.helpers
  isRecording: ->
    Session.get('Schnauze.Recorder:isRecording')

Template.recorder.events
  'mousedown, touchstart .js-recorder': (e, t) ->
    Schnauze.Recorder.record()
  
  'mouseup, touchend .js-recorder': (e, t) ->
    Schnauze.Recorder.stop()
