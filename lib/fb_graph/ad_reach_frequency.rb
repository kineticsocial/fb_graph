module FbGraph
  class AdReachFrequency < Node
    ATTRS = [
      :id, 

      # attributes particular to prediction creation only
      :budget,
      :destination_id,
      :time_start, # the same as campaign_time_start
      :time_end, # the same as campaign_time_end
      :prediction_id_share,
      :objective,
      :prediction_mode,
      :objective,
      :reach,

      # attributes returned when reading the prediction
      :account_id,
      :campaign_id,
      :time_created,
      :frequency_cap,
      :external_reach,
      :external_budget,
      :external_impression,
      :external_maximum_reach,
      :external_maximum_impression,
      :external_maximum_budget,
      :external_minimum_budget,
      :external_minimum_reach,
      :external_minimum_impression,
      :story_event_type,
      :target_audience_size,
      :prediction_mode,
      :prediction_progress,
      :status,
      :time_updated,
      :campaign_time_start,
      :campaign_time_stop,
      :reservation_status,

      # attributes related to reserving prediction
      :rf_prediction_id,
      :action,
      :rf_prediction_id_to_release,
      :impression
    ]

    # cause FB gives a string representation of a Hash instead of JSON object
    HASH_ATTRS = [:target_spec, :curve_budget_reach]

    attr_accessor *(ATTRS + HASH_ATTRS)

    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

    protected

    def set_attrs(attributes)
      ATTRS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end

      HASH_ATTRS.each do |field|
        case attributes[field.to_sym]
        when String
          send("#{field}=", JSON.parse(attributes[field.to_sym]))
        else
          send("#{field}=", attributes[field.to_sym])
        end
      end
    end
  end
end
