Template.listItem.onCreated () ->
  inst = Template.instance()
  Schnauze.EventEmitter.on 'Marker:openAudio', (payload) ->
    inst.data.selectedItem.set payload.audio._id

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst.data.audio._id

Template.listItem.events
  'click .js-openPlay': (e, t) ->
    Schnauze.EventEmitter.emit 'ListItem:openPlayAudio',
      audio: t.data.audio

    t.data.selectedItem.set t.data.audio._id
