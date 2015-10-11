Template.listItem.onCreated () ->
  self = @
  self.isPlaying = new ReactiveVar false
  self.isLoading = new ReactiveVar false

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst

  isPlaying: () ->
    Template.instance().isPlaying.get()

  isLoading: () ->
    Template.instance().isLoading.get()

  playCount: () ->
    @audio.playCount or 1

  lifetime: () ->
    settings = Schnauze.Settings.audioSnippets

    # window.waveScale = waveScale = d3.scale.linear()
    #   .domain([settings.defaultLifetimeMinutes, settings.maxLifetimeMinutes])
    #   .range([1, 10])

    lifetime = @audio.lifetime or settings.defaultLifetimeMinutes

    #changeWaveIcon(Template.instance(), Math.round(waveScale(lifetime)))
    
    lifetime

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

  'click .js-extendLife': (e, t) ->
    Schnauze.EventEmitter.emit 'ListItem:extendLife', 
      audio: t.data.audio

changeWaveIcon = (t, level) ->
  icon = t.$('.js-pulse-icon')
  currentID = icon.data('current')
  currentIcon = icon.find('.pulse_path-' + currentID)

  newID = level
  newIcon = icon.find('.pulse_path-' + newID)

  icon.data('current', newID)

  tl = new TimelineMax

  tl.to(currentIcon, 0.4,
    strokeDashoffset: -137
    clearProps: 'all'
  ).set(newIcon,
    strokeDashoffset: 137
  ).set(icon,
    className: '-=is-pulse-' + currentID
  ).set(icon,
    className: '+=is-pulse-' + newID
  ).to(newIcon, 0.4,
    strokeDashoffset: 0
    clearProps: 'all'
  )