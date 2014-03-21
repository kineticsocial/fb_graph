module FbGraph
  class AdInterest < Node
    extend Searchable

    attr_accessor :name, :audience_size, :path

    def initialize(identifier, attributes = {})
      super

      %w(name audience_size path).each do |field|
        self.send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end

