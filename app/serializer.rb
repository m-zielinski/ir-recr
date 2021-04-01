class Serializer
  def initialize(object)
    @object = object
  end

  def serialize
    object.to_h.map do |attribute, value|
      [attribute, send(attribute)]
    end.to_h
  end

  def self.attribute(name, &block)
    self.define_method(name) do
      block_given? ? self.instance_exec(&block): object.send(name)
    end
  end

  private

  attr_reader :object
end
