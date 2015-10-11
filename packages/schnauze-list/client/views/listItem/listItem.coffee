Template.listItem.onCreated () ->
  self = @
  self.isPlaying = new ReactiveVar false
  Schnauze.EventEmitter.on 'Marker:openAudio', (payload) ->
    self.data.selectedItem.set payload.audio._id

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst.data.audio._id

  isPlaying: () ->
    Template.instance().isPlaying.get()

Template.listItem.events
  'click .js-open': (e, t) ->
    t.data.selectedItem.set t.data.audio._id

  'click .js-playPause': (e, t) ->
    if self.isPlaying.get()
      self.isPlaying.set false
    else
      self.isPlaying.set true
      Schnauze.EventEmitter.emit 'ListItem:playAudio',
        audio: t.data.audio
