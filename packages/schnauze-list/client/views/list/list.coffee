Template.list.onCreated () ->
  self = @
  self.selectedItem = new ReactiveVar 0
  
  self.loaded = false
  self.ws = Schnauze.Player.getInstance()

  Tracker.autorun () ->
    item = self.selectedItem.get()
    if item
      # unless self.loaded
      console.log '==========', item
      if not _.isEmpty self.ws
        self.ws.destroy()

      self.ws.init Schnauze.Player.getConfig
        container: ".js-wavesurfer-#{item.data.audio._id}"

      self.ws.load item.data.audio.url()
    
      self.ws.on 'ready', () ->
        self.ws.play()

      self.ws.on 'finish', () ->
        item.isPlaying.set false
        # self.loaded = true
      Tracker.autorun () ->
        playing = item.isPlaying.get()
        console.log '==========', playing
        if playing
          self.ws.play()
        else
          self.ws.pause()

Template.list.helpers
  selectedItem: () ->
    Template.instance().selectedItem

  snippets: () ->
    Schnauze.Collections.AudioSnippets.find({ inRadius: yes }, {sort: uploadedAt: -1})