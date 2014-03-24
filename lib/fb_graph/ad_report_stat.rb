module FbGraph
  class AdReportStat < Node
    DATA_COLUMNS = [
      :account_id, #The ad account id
      :account_name, #The ad account name
      :adgroup_id, #The ad group id
      :adgroup_name, #The ad group name
      :campaign_id, #The campaign id
      :campaign_name, #The campaign name
      :campaign_group_id, #The campaign id
      :campaign_group_name, #The campaign name
      :inline_actions, #Actions taken on an ad, includes title_clicks, like, rsvp_yes, rsvp_maybe, post_like, comment, photo_view, link_click, video_play, question_vote
      :actions, #Actions taken within 1 day of viewing or 28 days after clicking an ad
      :actions_1d_view, #Actions taken within 1 day of viewing an ad (by impression time)
      :actions_7d_view, #Actions taken within 7 days of viewing an ad (by impression time)
      :actions_28d_view, #Actions taken within 28 days of viewing an ad (by impression time)
      :actions_1d_click, #Actions taken within 1 day of clicking an ad (by impression time)
      :actions_7d_click, #Actions taken within 7 days of clicking an ad (by impression time)
      :actions_28d_click, #Actions taken within 28 days of clicking an ad (by impression time)
      :actions_1d_view_by_convs, #Number of actions within 1 day of viewing an ad (by action/conversion time)
      :actions_7d_view_by_convs, #Number of actions within 7 days of viewing an ad (by action/conversion time)
      :actions_28d_view_by_convs, #Number of actions within 28 days of viewing an ad (by action/conversion time)
      :actions_1d_click_by_convs, #Number of actions within 1 day of clicking an ad (by action/conversion time)
      :actions_7d_click_by_convs, #Number of actions within 7 days of clicking an ad (by action/conversion time)
      :actions_28d_click_by_convs, #Number of actions within 28 days of clicking an ad (by action/conversion time)
      :action_values, #Value of actions, credits spent or mobile app actions taken on an ad
      :action_values_1d_view, #Value returned from actions, credits spent or mobile app actions within 1 day of viewing an ad (by impression time)
      :action_values_7d_view, #Value returned from actions, credits spent or mobile app actions within 7 days of viewing an ad (by impression time)
      :action_values_28d_view, #Value returned from actions, credits spent or mobile app actions within 28 days of viewing an ad (by impression time)
      :action_values_1d_click, #Value returned from actions, credits spent or mobile app actions within 1 day of clicking an ad (by impression time)
      :action_values_7d_click, #Value returned from actions, credits spent or mobile app actions within 7 day of clicking an ad (by impression time)
      :action_values_28d_click, #Value returned from actions, credits spent or mobile app actions within 28 day of clicking an ad (by impression time)
      :action_values_1d_view_by_convs, #Value returned from actions, credits spent or mobile app actions within 1 day of viewing an ad (by action/conversion time)
      :action_values_7d_view_by_convs, #Value returned from actions, credits spent or mobile app actions within 7 days of viewing an ad (by action/conversion time)
      :action_values_28d_view_by_convs, #Value returned from actions, credits spent or mobile app actions within 28 days of viewing an ad (by action/conversion time)
      :action_values_1d_click_by_convs, #Value returned from actions, credits spent or mobile app actions within 1 day of clicking an ad (by action/conversion time)
      :action_values_7d_click_by_convs, #Value returned from actions, credits spent or mobile app actions within 7 days of clicking an ad (by action/conversion time)
      :action_values_28d_click_by_convs, #Value returned from actions, credits spent or mobile app actions within 28 days of clicking an ad (by action/conversion time)
      :total_actions, #Total number of actions within 1 day of viewing or 28 days after clicking an ad
      :total_actions_1d_view, #Total number of actions within 1 day of viewing an ad (by impression time)
      :total_actions_7d_view, #Total number of actions within 7 days of viewing an ad (by impression time)
      :total_actions_28d_view, #Total number of actions within 28 days of viewing an ad (by impression time)
      :total_actions_1d_click, #Total number of actions within 1 day of clicking an ad (by impression time)
      :total_actions_7d_click, #Total number of actions within 7 days of clicking an ad (by impression time)
      :total_actions_28d_click, #Total number of actions within 28 days of clicking an ad (by impression time)
      :total_actions_by_convs, #Total number of actions the intiial viewing of or clicking on the ad (by action/conversion time)
      :total_unique_actions, #Total number of unique actions taken after viewing or clicking on the ad
      :total_unique_actions_1d_view, #Total number of unique actions within 1 day of viewing an ad (by impression time
      :total_unique_actions_7d_view, #Total number of unique actions within 7 days of viewing an ad (by impression time)
      :total_unique_actions_28d_view, #Total number of unique actions within 28 days of viewing an ad (by impression time)
      :total_unique_actions_1d_click, #Total number of unique actions within 1 day of clicking an ad (by impression time)
      :total_unique_actions_7d_click, #Total number of unique actions within 7 days of clicking an ad (by impression time)
      :total_unique_actions_28d_click, #Total number of unique actions within 28 days of clicking an ad
      :total_unique_actions_by_convs, #Total number of unique actions within 1 day of viewing or clicking the ad
      :unique_actions, #Total number of unique actions within 1 day of viewing or 28 days after clicking an ad
      :unique_actions_1d_view, #Number of unique actions within 1 day of viewing an ad (by impression time)
      :unique_actions_7d_view, #Number of unique actions within 7 days of viewing an ad (by impression time)
      :unique_actions_28d_view, #Number of unique actions within 28 days of viewing an ad (by impression time)
      :unique_actions_1d_click, #Number of unique actions within 1 day of clicking an ad (by impression time)
      :unique_actions_7d_click, #Number of unique actions within 7 days of clicking an ad (by impression time)
      :unique_actions_28d_click, #Number of unique actions within 28 days of clicking an ad (by impression time)
      :unique_actions_1d_view_by_convs, #Number of unique actions within 1 day of viewing an ad (by action/conversion time)
      :unique_actions_7d_view_by_convs, #Number of unique actions within 7 days of viewing an ad (by action/conversion time)
      :unique_actions_28d_view_by_convs, #Number of unique actions within 28 days of viewing an ad (by action/conversion time)
      :unique_actions_1d_click_by_convs, #Number of unique actions within 1 day of clicking an ad (by action/conversion time)
      :unique_actions_7d_click_by_convs, #Number of unique actions within 7 days of clicking an ad (by action/conversion time)
      :unique_actions_28d_click_by_convs, #Number of unique actions within 28 days of clicking an ad (by action/conversion time)
      :age, #The age range of the people you've reached
      :placement, #Where ad was shown on Facebook, such as on News Feed on a mobile device or on the right-side of Facebook on a desktop computer
      :country, #The countries where the people reached are located
      :gender, #Gender of the people reached
      :clicks, #Total number of clicks
      :cost_per_action_type, #Cost of each action type
      :cost_per_total_action, #Cost of all actions
      :cost_per_unique_click, #Cost of each unique click
      :cpc, #Cost per click
      :cpm, #Cost per impressions
      :cpp, #Cost per 1000 people reached
      :ctr, #Click-through rate
      :frequency, #Average number of times each person saw the ad
      :impressions, #Total number of times the ad was viewed
      :reach, #Total number of unique people who saw the ad
      :social_clicks, #Number of times the ad was clicked with social information
      :social_reach, #Number of unique people who saw the ad with social information
      :spend, #Total amount spent on the ad. Note that this does not work with action breakdowns
      :unique_clicks, #Number of unique people who have clicked on the ad
      :unique_ctr, #Number of people who clicked on the ad divided by the unique people reached
      :unique_impressions, #Number unique people who saw the ad
      :unique_social_clicks, #Number of unique people who have clicked on the ad with social context
      :unique_social_impressions #Number of unique people who have viewed the ad with social context
    ]
    
    DATE_COLUMNS = [
      :date_start, #Start date of the report
      :date_stop #End date of the report
    ]
    
    TIME_COLUMNS = [
      :time_start, #Start date of of the report in unix time stamp
      :time_stop #End date of the report in unix time stamp      
    ]
    
    # Accessors
    attr_accessor(*[DATA_COLUMNS + DATE_COLUMNS + TIME_COLUMNS].flatten)
      
    # Clean up and assign values
    # identifier will be returned from Facebook if async
    def initialize(identifier, attributes = {})
      super

      DATA_COLUMNS.each do |field|
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
