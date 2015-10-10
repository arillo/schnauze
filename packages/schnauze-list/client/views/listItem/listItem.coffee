Template.listItem.onCreated () ->

Template.listItem.helpers
  player: () ->
    #console.log @_id
    #console.log WaveSurfer
    Schnauze.Player.createInstance {container: document.querySelector('#waveform-' + @_id)}
    #config = _.extend {container: document.querySelector('#waveform-' + @data._id),}, Schnauze.Settings.player
    ###
    @wavesurfer.init
      container: document.querySelector('#waveform-' + @data._id),
      waveColor: '#A8DBA8',
      progressColor: '#3B8686'
    ###

Template.listItem.events
  'click .js-listItem': (e, t) ->
    $el = $(e.target).closest('.js-listItem').parent()
    e.stopImmediatePropagation()
    if $el.hasClass 'is-playing'
      $el.removeClass 'is-playing'
    else
      $el.addClass 'is-playing'

