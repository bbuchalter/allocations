class window.Stream

  constructor: (url, accumulator) ->
    @websocket = new WebSocket(url)
    @websocket.onmessage = @read
    @accumulator = accumulator

  read: (data) =>
    console.log(data)
    @accumulator.append(JSON.parse(data.data))
