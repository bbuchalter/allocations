require 'objspace'
require 'stream'
require 'graph_data'

class ApplicationController < ActionController::Base

  include Tubesock::Hijack

  $stream = Stream.new

  protect_from_forgery with: :exception

  def test
    render text: 'create some string'
  end

  def start
    ActiveSupport::Notifications.subscribe('start_processing.action_controller') do |*args|
      # GC.disable
    end
    ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
      p 'invoking object space'
      if $stream.connected?
        ObjectSpace.each_object(ActionView::Base) do |obj|
          stream_object_data! obj
        end
      end
      # GC.enable
      GC.start
    end
    head :ok
  end

  def stop
    ActiveSupport::Notifications.unsubscribe('start_processing.action_controller')
    ActiveSupport::Notifications.unsubscribe('process_action.action_controller')
    head :ok
  end

  def index
    @objects = ObjectSpace.each_object(ActionController::Base)
  end

  def graph
  end

  def data
    hijack do |websocket|
      websocket.onopen do
        $stream = Stream.new(websocket)
      end
      websocket.onclose do
        $stream = Stream.new
      end
    end
  end

  private

  def stream_object_data!(obj, depth=0)
    if depth >= 5
      references = []
    else
      references = ObjectSpace.reachable_objects_from(obj).map {|r| stream_object_data!(r, depth + 1) }
    end
    references = []
    $stream.write({name: obj.class.to_s, references: references}.to_json)
    # $stream.write ObjectData.new(obj.class.to_s, obj.object_id, references)
  end
end
