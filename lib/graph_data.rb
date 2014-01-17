require File.expand_path('./../object_data', __FILE__)

class GraphData

  Node = Struct.new(:name, :group)
  Link = Struct.new(:source, :target, :value) do
    def inc
      Link.new(source, target, value + 1)
    end
  end

  def initialize(objects)
    @objects = objects
  end

  def nodes
    @nodes ||= (@objects + @objects.flat_map(&:references)).uniq(&:klass).map.with_index do |obj, i|
      Node.new(obj.klass, i)
    end
  end

  def links
    @links ||= flat_links.group_by {|link| [link.source, link.target] }.map do |(attrs, links)|
      Link.new(*attrs, links.count)
    end
  end

  def to_json
    {nodes: nodes, links: links}.to_json
  end

  private

  def flat_links
    @objects.flat_map do |obj|
      source = index_of(obj)
      obj.references.map do |ref|
        Link.new(source, index_of(ref), 1)
      end
    end
  end

  def index_of(obj)
    nodes.index {|n| n.name == obj.klass }
  end

end