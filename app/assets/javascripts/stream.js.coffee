class window.Stream

  constructor: (url, accumulator) ->
    @url = url
    @accumulator = accumulator
    @websocket = null
    @readCount = 0

  read: (data) =>
    return unless @websocket

    console.log(data)
    @accumulator.append(JSON.parse(data.data))

  resetCount: ->
    @readCount = 0

  updateReadCount: =>
    @readCount += 1
    $("#read-count").html(@readCount)

  connect: ->
    @websocket = new WebSocketConnection(@url)
    @websocket.addCallback(@read)
    @websocket.addCallback(@updateReadCount)
