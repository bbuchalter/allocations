class window.WebSocketConnection
  constructor: (@url) ->
    @ws           = new WebSocket(@url)
    @ws.onmessage = @onMessage
    @callbacks    = []

  addCallback: (callback) ->
    @callbacks.push callback

  onMessage: (event) =>
    for callback in @callbacks
      callback.call @, event
