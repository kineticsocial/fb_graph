module FbGraph
  class AdCampaignGroup < Node
    include Connections::AdCampaigns
    include Connections::AdInsights
    
    attr_accessor :account_id, :name, :objective, :campaign_group_status, :is_completed
    
    def initialize(identifier, attributes = {})
      super
      set_attrs(attributes)
    end

    def update(options)
      response = super(options)
      response
    end

    protected

    def set_attrs(attributes)
      %w(account_id name objective campaign_group_status is_completed).each do |field|
        send("#{field}=", attributes[field.to_sym])
      end
    end
  end
end