class ObjectData

  attr_reader :klass, :id, :references

  def initialize(klass, id, references=[])
    @klass = klass
    @id = id
    @references = references
  end

end