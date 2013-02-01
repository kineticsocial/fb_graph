module FbGraph
  class OffsitePixel < Node
    include Connections::OffsitePixels
    
    attr_accessor :name, :tag

    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

  protected

    def set_attrs(attributes)
      %w(name tag).each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end
