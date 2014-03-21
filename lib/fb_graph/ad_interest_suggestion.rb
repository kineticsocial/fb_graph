module FbGraph
  class AdInterestSuggestion < AdInterest
    def self.search_query_param
      :interest_list
    end
  end
end

