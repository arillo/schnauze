Template.listItem.onCreated () ->
  self = @
  self.isPlaying = new ReactiveVar false
  self.isLoading = new ReactiveVar false

settings = Schnauze.Settings.audioSnippets
waveScale = d3.scale.linear()
  .domain([settings.defaultLifetimeMinutes, settings.maxLifetimeMinutes])
  .range([1, 10])

Template.listItem.helpers
  isSelected: () ->
    inst = Template.instance()
    inst.data.selectedItem.get() is inst

  isPlaying: () ->
    Template.instance().isPlaying.get()

  isLoading: () ->
    Template.instance().isLoading.get()

  lifetimeIcon: () ->
    Math.round(waveScale(@lifetime))

  isExtended: ->
    Session.get 'Schnauze.AudioSnippet:lifeExtended-' + @audio._id

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

    lifetime = t.data.audio.lifetime or settings.defaultLifetimeMinutes
    newLifetime = lifetime + settings.extendLifetimeMinutes

    return if newLifetime is settings.maxLifetimeMinutes

    currentID = Math.round(waveScale(t.data.audio.lifetime))
    newID = Math.round(waveScale(newLifetime))
    
    # currentID = icon.data('current')
    icon = t.$('.js-pulse-icon')
    currentIcon = icon.find('.pulse_path-' + currentID)
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
    
    Schnauze.EventEmitter.emit 'ListItem:extendLife', 
      id: t.data.audio._id
      newLifetime: newLifetime