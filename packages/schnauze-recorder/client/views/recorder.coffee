Template.recorder.onCreated () ->
  @isRecording = new ReactiveVar false
  @countdownTimer = new Schnauze.Utils.CountdownTimer
    duration: Schnauze.Settings.recorder.audioDurationSeconds

Template.recorder.helpers
  isRecording: () ->
    Template.instance().isRecording.get()
  countdown: () ->
    Template.instance().countdownTimer.countdown.get()

Template.recorder.events
  'mousedown, touchstart .js-recorder': (e, t) ->
    Schnauze.Recorder.record()
    t.isRecording.set true
    t.countdownTimer.start()

  'mouseleave, mouseup, touchend .js-recorder': (e, t) ->
    Schnauze.Recorder.stop()
    t.isRecording.set false
    t.countdownTimer.stop()
