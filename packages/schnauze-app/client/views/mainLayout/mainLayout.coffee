Template.mainLayout.onCreated () ->
  @listState = new ReactiveVar off

  changeListState = () ->
    @listState.set not @listState.get()

  openAudioHandler = () ->
    if !@listState.get()
      @listState.set true

  Schnauze.EventEmitter.on 'Menu:toggleList', _.bind(changeListState, @)
  Schnauze.EventEmitter.on 'Marker:openAudio', _.bind(openAudioHandler, @)

Template.mainLayout.helpers

  listStateClass: () ->
    if Template.instance().listState.get() then 'is-showingList' else ''

  showGeolocationError: () ->
    Session.get 'Schnauze.Error:geolocation'

  showRecorderError: () ->
    Session.get 'Schnauze.Error:recorder'

Schnauze.EventEmitter.on 'Geolocator:positionChangeError', (err) ->
  Session.set 'Schnauze.Error:geolocation', err

Schnauze.EventEmitter.on 'Recorder:notAllowedError', (err) ->
  Session.set 'Schnauze.Error:recorder', err


#Schnauze.EventEmitter.emit('Geolocator:positionChangeError')