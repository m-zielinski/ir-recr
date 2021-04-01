class Serializer
  def initialize(object)
    @object = object
    @@object = @object
  end

  def serialize
    object.to_h.map do |attribute, value|
      [attribute, send(attribute)]
    end.to_h
  end

  def self.attribute(name)
    self.define_method(name) do
      block_given? ? yield : object.send(name)
    end
  end

  def self.object
    @@object
  end

  private

  attr_reader :object
end
