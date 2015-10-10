class Schnauze.Utils.CountdownTimer
  constructor: (@options) ->
    @interval = null
    @countdown = new ReactiveVar @options.duration
  start: () ->
    @interval = Meteor.setInterval =>
      @countdown.set @countdown.get() - 1
      clearInterval(@interval) if @countdown.get() is 0
    , 1000
  stop: () ->
    clearInterval(@interval) if @interval
    @countdown.set @options.duration
