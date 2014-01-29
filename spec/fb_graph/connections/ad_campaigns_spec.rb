require 'spec_helper'
describe FbGraph::Connections::AdCampaigns, '#ad_campaign!' do
  context 'when included by FbGraph::AdCampaignGroup' do
    context 'when access_token is given' do
      it 'should return ad_campaigns as FbGraph::AdCampaign' do
        mock_graph :get, '6015568499638/adcampaigns', 'ad_campaign_groups/ad_campaigns/6015568499638_ad_campaigns', :access_token => 'access_token' do
          ad_campaigns = FbGraph::AdCampaignGroup.new('6015568499638', :access_token => 'access_token').ad_campaigns
          ad_campaigns.each { |ad_campaign| ad_campaign.should be_instance_of(FbGraph::AdCampaign) }
          ad_campaigns.first.should == FbGraph::AdCampaign.new(
            "6015568577438",
            :access_token => 'access_token',
            :name => "(15423) Test New Structure 1"
          )
        end
      end
    end
  end
  
  context 'when included by FbGraph::AdAccount' do
    it 'should return generated ad_account' do
      mock_graph :post, 'act_22334455/adcampaigns', 'ad_accounts/ad_campaigns/post_with_valid_access_token' do
        ad_campaign = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_campaign!(
          :name => "Campaign 1",
          :daily_budget => 500
        )

        ad_campaign.identifier.should == "6004167532222"
      end
    end

    it 'should handle the redownload parameter' do
      mock_graph :post, 'act_22334455/adcampaigns', 'ad_accounts/ad_campaigns/post_with_redownload' do
        ad_campaign = FbGraph::AdAccount.new('act_22334455', :access_token => 'valid').ad_campaign!(
          :name => "Campaign 1",
          :daily_budget => 500,
          :redownload => true
        )

        ad_campaign.identifier.should == "6004167532222"
        ad_campaign.account_id.should == 22334455
        ad_campaign.name.should == "Campaign 1"
        ad_campaign.daily_budget.should == 500
        ad_campaign.campaign_status.should == 2
        ad_campaign.daily_imps.should == 0
        ad_campaign.start_time.should == Time.at(1330282800)
        ad_campaign.end_time.should == Time.at(1330588800)
        ad_campaign.updated_time.should == Time.at(1329850926)
      end
    end
  end
end

