module FbGraph
  class AdInsight < Node
    include Connections::AdInsights
    
    #
    # Data Break downs
    #
    DATA_BREAKDOWN_COLUMNS = [
      :age,
      :country,
      :gender,
      :placement,
      :impression_device
    ]
    
    #
    # Dimensions
    #
    DIMENSION_COLUMN_TYPES = {
      :account_id => {:type => :integer}, # The ad account id
      :account_name => {:type => :string}, # The ad account name
      :adgroup_id => {:type => :integer}, # The ad group id
      :adgroup_name => {:type => :string}, # The ad group name
      :campaign_id => {:type => :integer}, # The campaign id
      :campaign_name => {:type => :string}, # The campaign name
      :campaign_group_id => {:type => :integer}, # The campaign group id
      :campaign_group_name => {:type => :string} #The campaign group name
    }
    DIMENSION_COLUMNS = DIMENSION_COLUMN_TYPES.keys
    
    #
    # Actions
    #
    DATA_ACTION_TYPES = {
      :action_values => {:type => :object, :sub_type => :decimal},
      :actions => {:type => :object, :sub_type => :integer}, 
      :unique_actions => {:type => :object, :sub_type => :integer},
      :cost_per_action_type => {:type => :object, :sub_type => :decimal}
    }
    DATA_ACTION_COLUMNS = DATA_ACTION_TYPES.keys
    
    #
    # Video
    #
    VIDEO_ACTION_COLUMN_TYPES = {
      :video_avg_pct_watched_actions => {:type => :object, :sub_type => :percent},
      :video_avg_sec_watched_actions => {:type => :object, :sub_type => :integer},
      :video_complete_watched_actions => {:type => :object, :sub_type => :integer},
      :video_p25_watched_actions => {:type => :object, :sub_type => :integer}, 
      :video_p50_watched_actions => {:type => :object, :sub_type => :integer}, 
      :video_p75_watched_actions => {:type => :object, :sub_type => :integer}, 
      :video_p95_watched_actions => {:type => :object, :sub_type => :integer}, 
      :video_p100_watched_actions => {:type => :object, :sub_type => :integer}, 
      :video_start_actions => {:type => :object, :sub_type => :integer}
    }
    VIDEO_ACTION_COLUMNS = VIDEO_ACTION_COLUMN_TYPES.keys
    
    #
    # General Fields
    #
    DATA_COLUMN_TYPES = {
      :actions_per_impression => {:type => :integer},
      :deeplink_clicks => {:type => :integer},
      :app_store_clicks => {:type => :integer},
      :call_to_action_clicks => {:type => :integer},
      :clicks => {:type => :integer},
      :unique_clicks => {:type => :integer},
      :cost_per_result => {:type => :decimal},
      :cost_per_total_action => {:type => :decimal},
      :cpc => {:type => :decimal},
      :cost_per_unique_click => {:type => :decimal},
      :cpm => {:type => :decimal},
      :cpp => {:type => :decimal},
      :ctr => {:type => :decimal},
      :unique_ctr => {:type => :decimal},
      :frequency => {:type => :decimal},
      :impressions => {:type => :integer},
      :unique_impressions => {:type => :integer},
      :objective => {:type => :string},
      :performance_indicator => {:type => :string},
      :reach => {:type => :integer},
      :result_rate => {:type => :decimal},
      :results => {:type => :integer},
      :relevance_score => {:type => :object, :sub_type => :string},
      :roas => {:type => :decimal},
      :social_clicks => {:type => :integer},
      :unique_social_clicks => {:type => :integer},
      :social_impressions => {:type => :integer},
      :unique_social_impressions => {:type => :integer},
      :social_reach => {:type => :integer},
      :spend => {:type => :decimal},
      :today_spend => {:type => :decimal},
      :total_action_value => {:type => :decimal},
      :total_actions => {:type => :integer},
      :total_unique_actions => {:type => :integer},
      :website_clicks => {:type => :integer},
      :website_ctr => {:type => :integer},
      :product_id => {:type => :integer}
    }
    DATA_COLUMNS = DATA_COLUMN_TYPES.keys

    # Dimension + Column for Action reporting
    # Note that the 'spend' field in 'data_columns' does not work with action breakdowns
    ACTION_COLUMNS = [
      :action_target_id,
      :action_target_name,
      :action_type,
      :action_device, # The device type on which off-Facebook actions were taken
      :action_video_type
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
    
    ALL_COLUMN_TYPES = DIMENSION_COLUMN_TYPES.merge(DATA_ACTION_TYPES).merge(VIDEO_ACTION_COLUMN_TYPES).merge(DATA_COLUMN_TYPES)
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