Template.menu.events
  'click .js-locate-on-map': (e, t) ->
    Schnauze.EventEmitter.emit 'Menu:centerMap'