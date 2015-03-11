module FbGraph
  module Connections
    module ReportStats
      # This returns an Array of statistics
      def report_stats(options = {})
        report_stats = self.connection :reportstats, options
        report_stats.map! do |report_stat|
          ReportStat.new nil, report_stat.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end
      
      def report_stat!(options = {})
        options.merge!(:async => true)
        report_stat = self.post options.merge(:connection => :reportstats)
        ReportStat.new report_stat.id, {:access_token => options[:access_token] || self.access_token}
      end
    end
  end
end