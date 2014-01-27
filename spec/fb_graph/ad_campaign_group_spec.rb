require 'spec_helper'
=begin
describe FbGraph::AdCampaignGroup, '.new' do
  it 'should setup all supported attributes' do
    attributes = {
      :id => '6003266501234',
      :account_id => 12345566,
      :name => "Test Ad Campaign Group",
      :objective => 'MOBILE_APP_INSTALLS',
      :campaign_group_status => 'ACTIVE',
      :is_completed => 1
    }
    ad_campaign_group = FbGraph::AdCampaignGroup.new(attributes.delete(:id), attributes)
    ad_campaign_group.identifier.should == "6003266501234"
    ad_campaign_group.account_id.should == 12345566
    ad_campaign_group.name.should == 'Test Ad Campaign Group'
    ad_campaign_group.objective.should == 'MOBILE_APP_INSTALLS'
    ad_campaign_group.campaign_group_status.should == 'ACTIVE'
    ad_campaign_group.is_complete.should == 1
  end
end

describe FbGraph::AdCampaignGroup, '.fetch' do
  it 'should get the ad campaign group' do
    mock_graph :get, '16003266501234', 'ad_campaign_groups/test_ad_campaign_group', :access_token => 'access_token' do
      ad_campaign_group = FbGraph::AdCampaignGroup.fetch('16003266501234', :access_token => 'access_token')

      ad_campaign_group.identifier.should == "6003266501234"
      ad_campaign_group.account_id.should == 12345566
      ad_campaign_group.name.should == "Test Ad Campaign"
      ad_campaign_group.objective.should == 'MOBILE_APP_INSTALLS'
      ad_campaign_group.campaign_group_status.should == 'ACTIVE'
      ad_campaign_group.is_complete.should == 1
    end
  end
end

describe FbGraph::AdCampaignGroup, '.update' do
  context "with name attribute" do
    it "should update the dCampaignGroup with the new data from facebook" do
      mock_graph :post, "6004167532222", 'ad_campaign_groups/test_ad_campaign_group', :name => "New Name" do
        attributes = {
          :id => "6004167532222",
          :name => "New Name"
        }

        ad_campaign_group = FbGraph::AdCampaignGroup.new(attributes.delete(:id), attributes)
        ad_campaign_group.update(:name => "New Name")
        ad_campaign.name.should == "New Name"
      end
    end
  end
end
=end