Schnauze.Player = 
  instance: null

  createInstance: (config) ->
    config = _.extend config, Schnauze.Settings.player
    console.log config

  destroyInstance: ->
    if instance?
      instance.destroy()
