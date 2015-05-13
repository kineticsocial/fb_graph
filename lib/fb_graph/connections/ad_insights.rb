module FbGraph
  module Connections
    module AdInsights
      # This returns an Array of statistics
      def insights(options = {})
        insights = self.connection :insights, options
        insights.map! do |insight|
          AdInsight.new nil, insight.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end
      
      def insight!(options = {})
        options.merge!(:async => true)
        insights = self.post options.merge(:connection => :insights)
        AdInsight.new insights['report_run_id'], {:access_token => options[:access_token] || self.access_token}
      end
    end
  end
end