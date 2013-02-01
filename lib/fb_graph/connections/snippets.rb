module FbGraph
  module Connections
    module Snippets
      def snippets(options = {})
        snippets = self.connection :snippets, options
        snippets.map! do |snippet|
          Snippet.new nil, snippet.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end
    end
  end
end
