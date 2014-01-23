class ObjectData

  attr_reader :klass, :id, :references

  def initialize(klass, id, references=[])
    @klass = klass
    @id = id
    @references = references
  end

  def to_h
    {klass: @klass, object_id: @id, references: @references.map(&:to_h)}
  end

  def to_json
    to_h.to_json
  end

end