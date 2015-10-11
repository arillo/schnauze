Template.list.onCreated () ->
  self = @
  self.selectedItem = new ReactiveVar 0
  self.loaded = false
  self.ws = Schnauze.Player.getInstance()

  Tracker.autorun () ->
    item = self.selectedItem.get()
    if item
      if not _.isEmpty self.ws
        self.ws.destroy()

      self.ws.init Schnauze.Player.getConfig
        container: ".js-wavesurfer-#{item.data.audio._id}"

      self.ws.load item.data.audio.url()
      item.isLoading.set true
      self.ws.on 'ready', () ->
        item.isLoading.set false
        self.ws.play()
        item.isPlaying.set true

      self.ws.on 'finish', () ->
        item.isPlaying.set false
        Schnauze.EventEmitter.emit 'ListItem:openPlayAudio', 
          audio: item.data.audio
      
      Tracker.autorun () ->
        playing = item.isPlaying.get()
        if playing
          self.ws.play()
        else
          self.ws.pause()

  Schnauze.EventEmitter.on 'Marker:openAudio', (payload) ->
    $("[data-id='#{payload.id}'] .js-open").click()
    # @TODO: properly scroll to position
    # console.log 'offset', offset, $('.list').scrollTop()
    # $('.l-item-scroll').scrollTop($("[data-id='#{payload.id}']").offset().top - $("[data-id='#{payload.id}']").offsetParent().offset().top)
    # Meteor.setTimeout () ->
    #   offset = $("[data-id='#{payload.id}']").offsetParent().position().top
    #   console.log offset
    #   $('.l-item-scroll').scrollTop(offset)
    # , 450

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({ inRadius: yes }, {sort: uploadedAt: -1})
