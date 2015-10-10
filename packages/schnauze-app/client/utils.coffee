UI.registerHelper "formatDate", (datetime, format) ->
  return moment(datetime).fromNow() if format is 'fromNow'
  moment(datetime).format format