Template.listItem.onCreated () ->
  self = @
  self.isPlaying = new ReactiveVar false

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst

  isPlaying: () ->
    Template.instance().isPlaying.get()

  playCount: () ->
    console.log '#############', @
    @audio.playCount or 1

Template.listItem.events
  'click .js-open': (e, t) ->
    unless t.data.selectedItem.get() is t
      t.data.selectedItem.set t

  'click .js-playPause': (e, t) ->
    return unless t.data.selectedItem.get() is t
    if t.isPlaying.get()
      t.isPlaying.set false
    else
      t.isPlaying.set true