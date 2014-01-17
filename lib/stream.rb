class Stream

  def initialize(websocket=nil)
    @websocket = websocket
  end

  def write(data)
    @websocket.send_data data if @websocket
  end

  def connected?
    !!@websocket
  end

end
