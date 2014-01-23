class Stream

  def initialize(websocket=nil)
    @websocket = websocket
  end

  def write(data)
    if @websocket
      @websocket.send_data data
    end
  end

  def connected?
    !!@websocket
  end

end
