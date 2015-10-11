Template.list.onCreated () ->
  self = @
  self.selectedItem = new ReactiveVar 0
  self.loaded = false
  self.ws = Schnauze.Player.getInstance()

  Tracker.autorun () ->
    item = self.selectedItem.get()
    if item
      console.log '==========', item
      if not _.isEmpty self.ws
        self.ws.destroy()

      self.ws.init Schnauze.Player.getConfig
        container: ".js-wavesurfer-#{item.data.audio._id}"

      self.ws.load item.data.audio.url()
    
      self.ws.on 'ready', () ->
        self.ws.play()
        item.isPlaying.set true

      self.ws.on 'finish', () ->
        item.isPlaying.set false
      
      Tracker.autorun () ->
        playing = item.isPlaying.get()
        console.log '==========', playing
        if playing
          self.ws.play()
        else
          self.ws.pause()

  Schnauze.EventEmitter.on 'Marker:openAudio', (payload) ->
    $("[data-id='#{payload.id}'] .js-open").click()
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
