class window.Stream

  constructor: (url, accumulator) ->
    @url = url
    @accumulator = accumulator
    @websocket = null

  read: (data) =>
    return unless @websocket

    console.log(data)
    @accumulator.append(JSON.parse(data.data))

  connect: ->
    @websocket = new WebSocket(@url)
    @websocket.onmessage = @read
