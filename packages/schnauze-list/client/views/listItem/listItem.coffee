Template.listItem.onCreated () ->

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst.data.audio._id

Template.listItem.events
  'click .js-listItem': (e, t) ->
    console.log t.data.audio
    t.data.selectedItem.set t.data.audio._id
    audio = new Audio(t.data.audio.url())
    audio.volume = 1;
    audio.play()
    


  # player: () ->
  #   #console.log @_id
  #   #console.log WaveSurfer
  #   Schnauze.Player.createInstance {container: document.querySelector('#waveform-' + @_id)}
  #   #config = _.extend {container: document.querySelector('#waveform-' + @data._id),}, Schnauze.Settings.player
  #   ###
  #   @wavesurfer.init
  #     container: document.querySelector('#waveform-' + @data._id),
  #     waveColor: '#A8DBA8',
  #     progressColor: '#3B8686'
  #   ###