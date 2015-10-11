class Player
  constructor: () ->
    @instance = null
    console.log 'constructor'
    ws = @getInstance()

  getInstance: () ->
    return @instance if @instance
    @instance = Object.create(WaveSurfer)

  getConfig: (add) ->
    config = 
      waveColor: '#256A7B'
      progressColor: '#205e6e'
      cursorColor: 'transparent'
      height: 80
      normalize: true
      barWidth: 3
      hideScrollbar: true
    return _.extend config, add

Schnauze.Player = new Player

Schnauze.EventEmitter.on 'ListItem:playAudio', (payload) ->
  # audio = Schnauze.Collections.AudioSnippets.findOne({_id: payload.audio._id})
  ws = Schnauze.Player.getInstance()
  if not _.isEmpty ws
    ws.destroy()

  ws.init Schnauze.Player.getConfig
    container: ".js-wavesurfer-#{payload.audio._id}"

  ws.on 'ready', () ->
    ws.play()
  ws.load payload.audio.url()

Schnauze.EventEmitter.on 'Marker:openAudio', (payload) ->
  # audio = Schnauze.Collections.AudioSnippets.findOne({_id: payload.audio._id})
  ws = Schnauze.Player.getInstance()
  if not _.isEmpty ws
    ws.destroy()

  ws.init Schnauze.Player.getConfig
    container: ".js-wavesurfer-#{audio._id}"

  ws.load payload.audio.url()
