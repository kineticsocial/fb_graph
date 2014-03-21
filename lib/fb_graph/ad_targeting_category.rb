module FbGraph
  class AdTargetingCategory < Node
    extend Searchable

    attr_accessor :name, :audience_size, :path, :type

    def initialize(identifier, attributes = {})
      super

      %w(name audience_size path type).each do |field|
        self.send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end

