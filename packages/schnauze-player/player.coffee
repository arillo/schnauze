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
      waveColor: '#A8DBA8'
      progressColor: '#3B8686'
    return _.extend config, add

Schnauze.Player = new Player

Schnauze.EventEmitter.on 'ListItem:openPlayAudio', (payload) ->
  ws = Schnauze.Player.getInstance()
  if not _.isEmpty ws
    ws.destroy()

  ws.init Schnauze.Player.getConfig
    container: ".js-wavesurfer-#{payload.audio._id}"

  ws.on 'ready', () ->
    ws.play()
  ws.load payload.audio.url()

Schnauze.EventEmitter.on 'ListItem:loadAudio', (payload) ->
  audio = Schnauze.Collections.AudioSnippets.findOne({_id: payload.audio._id})
  ws = Schnauze.Player.getInstance()
  if not _.isEmpty ws
    ws.destroy()

  ws.init Schnauze.Player.getConfig
    container: ".js-wavesurfer-#{audio._id}"

  ###
  ws.on 'ready', () ->
    ws.play()
  ###
  ws.load audio.url()