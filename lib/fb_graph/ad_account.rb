module FbGraph
  class AdAccount < Node
    include Connections::AdCampaignGroups
    include Connections::AdCampaigns
    include Connections::AdGroups
    include Connections::AdCampaignStats
    include Connections::AdGroupStats
    include Connections::ReportStats
    include Connections::BroadTargetingCategories
    include Connections::ReachEstimates
    include Connections::AdConnectionObjects
    include Connections::AdPreviews
    include Connections::AdImages
    include Connections::AdCreatives
    include Connections::AdGroupConversionStats
    include Connections::OffsitePixels
    include Connections::CustomAudiences
    include Connections::PartnerCategories
    include Connections::UserPermissions
    include Connections::ReachFrequencyPredictions

    ATTRS = [
      :account_id,
      :name,
      :account_status,
      :daily_spend_limit,
      :users,
      :currency,
      :timezone_id,
      :timezone_name,
      :capabilities,
      :account_groups,
      :is_personal,
      :business_name,
      :business_street,
      :business_street2,
      :business_city,
      :business_state,
      :business_zip,
      :business_country_code,
      :tax_id_status,
      :agency_client_declaration,
      :spend_cap,
      :amount_spent,
      :balance,
      :created_time
    ]

    attr_accessor *ATTRS

    def initialize(identifier, attributes = {})
      super

      ATTRS.each do |field|
        send("#{field}=", attributes[field.to_sym])
      end

      users_attributes = attributes[:users]
      if users_attributes
        if users_attributes.kind_of?(Hash) && users_attributes[:data]
          self.users = users_attributes[:data].collect { |u| FbGraph::AdUser.new(u["id"], u) }
        elsif users_attributes.kind_of?(Array)
          self.users = users_attributes.collect { |u| FbGraph::AdUser.new(u["id"], u) }
        end
      end
    end
  end
end
