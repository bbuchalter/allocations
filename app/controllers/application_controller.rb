require 'objspace'
require 'graph_data'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def test
    render text: 'create some string'
  end

  def start
    ActiveSupport::Notifications.subscribe('start_processing.action_controller') do |*args|
      GC.disable
    end
    ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
      $objects = ObjectSpace.each_object(ActionView::Base).map &method(:object_data)
      GC.enable
      GC.start
    end
    head :ok
  end

  def stop
    ActiveSupport::Notifications.unsubscribe('start_processing.action_controller')
    ActiveSupport::Notifications.unsubscribe('process_action.action_controller')
    head :ok
  end

  def results
    @objects = ObjectSpace.each_object(ActionController::Base)
  end

  def graph
    @graph = GraphData.new($objects || [])
    GC.start
  end

  private

  def object_data(obj, depth=0)
    if depth >= 5
      references = []
    else
      references = ObjectSpace.reachable_objects_from(obj).map {|r| object_data(r, depth + 1) }
    end
    ObjectData.new(obj.class.to_s, obj.object_id, references)
  end
end
