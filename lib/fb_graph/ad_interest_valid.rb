module FbGraph
  class AdInterestValid < Node
    extend Searchable

    attr_accessor :name, :valid, :audience_size, :path

    def initialize(identifier, attributes = {})
      super

      %w(name valid).each do |field|
        self.send("#{field}=", attributes[field.to_sym])
      end
    end

    alias :valid? :valid

    def self.search_query_param
      :interest_list
    end
  end
end
