module FbGraph
  module Connections
    module AdReachFrequencies
      def ad_reach_frequencies(options = {})
        reach_frequency_predictions = self.connection :reachfrequencypredictions, options
        reach_frequency_predictions.map! do |reach_frequency_prediction|
          AdReachFrequency.new reach_frequency_prediction[:id], reach_frequency_prediction.merge(access_token: options[:access_token] || self.access_token)
        end
      end

      def ad_reach_frequency!(options = {})
        reach_frequency_prediction = post options.merge(connection: :reachfrequencypredictions)
        AdReachFrequency.new(reach_frequency_prediction.identifier, {access_token: options[:access_token] || self.access_token})
      end
    end
  end
end


