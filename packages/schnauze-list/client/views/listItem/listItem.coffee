Template.listItem.onCreated () ->

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst.data.audio._id

Template.listItem.events
  'click .js-openPlay': (e, t) ->
    Schnauze.EventEmitter.emit 'ListItem:openPlayAudio',
      audio: t.data.audio
    ###
    if t.data.audio._id == t.data.selectedItem.get()
      console.log 'alreday open'
    else
    ###
    t.data.selectedItem.set t.data.audio._id
