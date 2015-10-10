Template.mainLayout.onCreated () ->
  @listState = new ReactiveVar off

  changeListState = () ->
    @listState.set not @listState.get()

  Schnauze.EventEmitter.on 'Menu:toggleList', _.bind(changeListState, @)

Template.mainLayout.helpers

  listStateClass: () ->
    if Template.instance().listState.get() then 'is-showingList' else ''
