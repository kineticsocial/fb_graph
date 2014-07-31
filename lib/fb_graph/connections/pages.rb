module FbGraph
  module Connections
    module Pages
      def pages(options = {})
        pages = self.connection :pages, options
        pages.map! do |page|
          Page.new page[:id], page.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def pages!(options = {})
        page = post options.merge(:connection => :pages)
      end
    end
  end
end