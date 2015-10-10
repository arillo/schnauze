Template.listItem.onCreated () ->

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst.data.audio._id

Template.listItem.events
  'click .js-listItem': (e, t) ->
    t.data.selectedItem.set t.data.audio._id
    Schnauze.EventEmitter.emit 'ListItem:playAudio',
      audio: t.data.audio