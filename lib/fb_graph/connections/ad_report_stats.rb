module FbGraph
  module Connections
    module AdReportStats
      # This returns an Array of statistics
      def ad_report_stats(options = {})
        ad_report_stats = self.connection :reportstats, options
        ad_report_stats.map! do |ad_report_stat|
          AdReportStat.new nil, ad_report_stat.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end
      
      def ad_report_stat!(options = {})
        options.merge!(:async => true)
        ad_report_stat = self.post options.merge(:connection => :reportstats)
        AdReportStat.new ad_report_stat.identifier, {:access_token => options[:access_token] || self.access_token}
      end
    end
  end
end