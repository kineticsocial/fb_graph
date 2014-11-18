module FbGraph
  module Connections
    module ReachFrequencyPredictions
      def reach_frequency_predictions(options = {})
        reach_frequency_predictions = self.connection :reachfrequencypredictions, options
        reach_frequency_predictions.map! do |reach_frequency_prediction|
          ReachFrequencyPrediction.new reach_frequency_prediction[:id], reach_frequency_prediction.merge(access_token: options[:access_token] || self.access_token)
        end
      end

      def reach_frequency_prediction!(options = {})
        reach_frequency_prediction = post options.merge(connection: :reachfrequencypredictions)
        ReachFrequencyPrediction.new(reach_frequency_prediction.identifier, {access_token: options[:access_token] || self.access_token})
      end
    end
  end
end


