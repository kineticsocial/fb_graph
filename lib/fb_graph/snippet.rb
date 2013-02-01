module FbGraph
  class Snippet < Node
    attr_accessor :value

    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

    protected

    def set_attrs(attributes)
      %w(value).each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end

