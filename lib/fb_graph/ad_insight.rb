module FbGraph
  class AdInsight < Node
    include Connections::AdInsights
    
    DIMENSION_COLUMNS = [
      :account_id, #The ad account id
      :account_name, #The ad account name
      :adgroup_id, #The ad group id
      :adgroup_name, #The ad group name
      :campaign_id, #The campaign id
      :campaign_name, #The campaign name
      :campaign_group_id, #The campaign group id
      :campaign_group_name #The campaign group name
    ]

    DATA_BREAKDOWN_COLUMNS = [
      # Demographic
      :age, # The age range of the people you've reached
      :country, #T he countries where the people reached are located
      :gender, # Gender of the people reached
      :placement, # Where ad was shown on Facebook, such as on News Feed on a mobile device or on the right-side of Facebook on a desktop computer
      :impression_device # NOT a real breakdown column, but acts as one with placement
    ]

    DATA_ACTION_COLUMNS = [
      :action_values, 
      :actions, 
      :actions_per_impression,
      :unique_actions
    ]
    
    VIDEO_ACTION_COLUMNS = [
      :video_avg_pct_watched_actions, 
      :video_avg_sec_watched_actions, 
      :video_complete_watched_actions, 
      :video_p25_watched_actions, 
      :video_p50_watched_actions, 
      :video_p75_watched_actions, 
      :video_p95_watched_actions, 
      :video_p100_watched_actions, 
      :video_start_actions
    ]
    
    DATA_COLUMNS = [
      :deeplink_clicks, 
      :app_store_clicks, 
      :call_to_action_clicks, 
      :clicks, 
      :unique_clicks, 
      :cost_per_action_type, 
      :cost_per_result, 
      :cost_per_total_action, 
      :cpc, 
      :cost_per_unique_click, 
      :cpm, 
      :cpp, 
      :ctr, 
      :unique_ctr, 
      :frequency, 
      :impressions, 
      :unique_impressions, 
      :objective, 
      :performance_indicator, 
      :product_id, 
      :reach, 
      :result_rate, 
      :results, 
      :relevance_score, 
      :roas, 
      :social_clicks, 
      :unique_social_clicks, 
      :social_impressions, 
      :unique_social_impressions, 
      :social_reach, 
      :spend, 
      :today_spend, 
      :total_action_value, 
      :total_actions, 
      :total_unique_actions, 
      :website_clicks, 
      :website_ctr
    ]

    # Dimension + Column for Action reporting
    # Note that the 'spend' field in 'data_columns' does not work with action breakdowns
    ACTION_COLUMNS = [
      :action_target_id,
      :action_target_name,
      :action_type,
      :action_device # The device type on which off-Facebook actions were taken
    ]

    DATE_COLUMNS = [
      :date_start, #Start date of the report
      :date_stop #End date of the report
    ]

    TIME_COLUMNS = [
      :time_start, #Start date of of the report in unix time stamp
      :time_stop #End date of the report in unix time stamp
    ]

    ASYNC_STATUS_COLUMNS = [
      :async_status,
      :async_percent_completion
    ]

    ALL_COLUMNS = ACTION_COLUMNS + DIMENSION_COLUMNS + DATA_COLUMNS + DATE_COLUMNS + TIME_COLUMNS + ASYNC_STATUS_COLUMNS + DATA_ACTION_COLUMNS + VIDEO_ACTION_COLUMNS 
    ALL_DATA_COLUMNS = ACTION_COLUMNS + DIMENSION_COLUMNS + DATA_COLUMNS + ASYNC_STATUS_COLUMNS + DATA_ACTION_COLUMNS + VIDEO_ACTION_COLUMNS

    # Accessors
    attr_accessor *ALL_COLUMNS
    attr_accessor *DATA_BREAKDOWN_COLUMNS
    attr_accessor :report_run_id

    # Clean up and assign values
    # identifier will be returned from Facebook if async
    def initialize(identifier, attributes = {})
      super

      ALL_DATA_COLUMNS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end

      DATA_BREAKDOWN_COLUMNS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end

      TIME_COLUMNS.each do |field|
        if val = attributes[field.to_sym]
          #Handles integer timestamps and ISO8601 strings
          time = Time.parse(val) rescue Time.at(val.to_i)
          send("#{field}=", time)
        end
      end

      DATE_COLUMNS.each do |field|
        if val = attributes[field.to_sym]
          #Handles integer timestamps and ISO8601 strings
          date = Date.parse(val) rescue Date.at(val.to_i)
          send("#{field}=", date)
        end
      end
    end
  end
end