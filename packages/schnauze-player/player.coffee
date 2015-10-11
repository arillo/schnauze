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