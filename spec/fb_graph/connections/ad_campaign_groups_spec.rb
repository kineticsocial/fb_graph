require 'spec_helper'
describe FbGraph::Connections::AdCampaignGroups, '#ad_campaign_group!' do
  context 'when included by FbGraph::AdAccount' do
    it 'should return generated ad campaign group' do
      mock_graph :post, 'act_22334455/adcampaign_groups', 'ad_accounts/ad_campaign_groups/post_with_valid_access_token' do
        ad_campaign = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_campaign_group!(
          :name => "Campaign Group 1"
        )

        ad_campaign.identifier.should == "6015568499638"
      end
    end
  end
end