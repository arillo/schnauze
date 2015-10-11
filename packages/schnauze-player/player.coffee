class Player
  instance: null

  constructor: () ->
    console.log 'constructor'
    ws = @getInstance()

  getInstance: () ->
    return @instance if @instance
    @instance = Object.create(WaveSurfer)

  destroyInstance: ->
    if @instance?
      @instance.destroy()

Schnauze.Player = new Player

Schnauze.EventEmitter.on 'ListItem:playAudio', (payload) ->
  console.log 'ListItem:playAudio', payload.audio
  ws = Schnauze.Player.getInstance()
  ws.init
    container: ".js-wavesurfer-#{payload.audio._id}"
    waveColor: '#256A7B'
    progressColor: '#205e6e'
    cursorColor: 'transparent'
    height: 80
    normalize: true
    barWidth: 3
    hideScrollbar: true
  ws.on 'ready', () ->
    ws.play()
  ws.load payload.audio.url()