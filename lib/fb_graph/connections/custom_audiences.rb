module FbGraph
  module Connections
    module CustomAudiences
      def custom_audiences(options = {})
        custom_audiences = self.connection :customaudiences, options
        custom_audiences.map! do |custom_audience|
          CustomAudience.new custom_audience[:id], custom_audience.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def custom_audience!(options = {})
        custom_audience = post options.merge(:connection => :customaudiences)
        custom_audience_id = custom_audience[:id]

        merged_attrs = options.merge(
          :access_token => options[:access_token] || self.access_token
        )

        CustomAudience.new custom_audience_id, merged_attrs
      end
    end
  end
end
