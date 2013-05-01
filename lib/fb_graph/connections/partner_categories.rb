module FbGraph
  module Connections
    module PartnerCategories
      def partner_categories(options = {})
        partner_categories = self.connection :partnercategories, options
        partner_categories.map! do |pc|
          PartnerCategory.new pc[:id], pc.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end
    end
  end
end
