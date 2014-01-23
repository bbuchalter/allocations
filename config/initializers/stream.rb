require 'stream'

module Rails

  class << self
    attr_accessor :stream
  end

  self.stream = Stream.new

end