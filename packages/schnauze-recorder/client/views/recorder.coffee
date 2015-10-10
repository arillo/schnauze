Template.recorder.onCreated () ->
  self = @
  self.isRecording = new ReactiveVar false

Template.recorder.helpers
  isRecording: () ->
    Template.instance().isRecording.get()

Template.recorder.events
  'mousedown, touchstart .js-recorder': (e, t) ->
    Schnauze.Recorder.record()
    t.isRecording.set true

  'mouseup, touchend .js-recorder': (e, t) ->
    Schnauze.Recorder.stop()
    t.isRecording.set false

