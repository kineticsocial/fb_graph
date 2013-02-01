module FbGraph
  class Snippet < Node
    attr_accessor :value, :js

    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

    protected

    def set_attrs(attributes)
      %w(value js).each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end

