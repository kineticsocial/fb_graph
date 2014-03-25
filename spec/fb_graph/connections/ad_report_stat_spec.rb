require 'spec_helper'

describe FbGraph::Connections::AdCampaigns, '#ad_report_stat!' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should create ad_report_stat asyncronized request as FbGraph::AdReportStat' do        
        mock_graph :post, 'act_12345566/reportstats', 'ad_accounts/ad_report_stats/test_ad_report_stats_async', :params => {:async => "true"}, :access_token => 'access_token' do
          ad_report_stat = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').ad_report_stat!
          ad_report_stat.should be_instance_of(FbGraph::AdReportStat)
          ad_report_stat.should == FbGraph::AdReportStat.new(
            6018478973531,
            :access_token => 'access_token'
          )
        end
      end
    end
  end
end
  
describe FbGraph::Connections::AdReportStats, '#ad_report_stats' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return ad_report_stats as FbGraph::AdReportStat' do
        mock_graph :get, 'act_12345566/reportstats?data_columns=["adgroup_id","actions","spend"]&date_preset=last_week', 'ad_accounts/ad_report_stats/test_ad_report_stats', :access_token => 'access_token' do
          options = {
            :date_preset => :last_week,
            :data_columns => [:adgroup_id, :actions, :spend]
          }
          ad_report_stats = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').ad_report_stats(options)

          ad_report_stats.size.should == 2
          ad_report_stats.each { |ad_report_stat| ad_report_stat.should be_instance_of(FbGraph::AdReportStat) }
          ad_report_stat = ad_report_stats.first
          ad_report_stat.should == FbGraph::AdReportStat.new(
            nil,
            :adgroup_id => 6018408642331,
            :date_start => "2014-03-20",
            :date_stop => "2014-03-20",
            :actions => 3,
            :spend => 1.5,
            :access_token => 'access_token'
          )
          
          ad_report_stat.date_start.should be_instance_of(Date)
          ad_report_stat.date_stop.should be_instance_of(Date)
        end
      end
      
      it 'should return asyncronized ad_report_stats as FbGraph::AdReportStat' do
        mock_graph :get, 'act_12345566/reportstats?report_run_id=6018494456931', 'ad_accounts/ad_report_stats/test_ad_report_stats_async_results', :access_token => 'access_token' do
          options = {
            :report_run_id => 6018494456931
          }
          ad_report_stats = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').ad_report_stats(options)

          ad_report_stats.size.should == 2
          ad_report_stats.each { |ad_report_stat| ad_report_stat.should be_instance_of(FbGraph::AdReportStat) }
          ad_report_stat = ad_report_stats.first
          ad_report_stat.should == FbGraph::AdReportStat.new(
            nil,
            :adgroup_id => 6018408642331,
            :date_start => "2014-03-20",
            :date_stop => "2014-03-20",
            :actions => 3,
            :spend => 1.5,
            :access_token => 'access_token'
          )
          
          ad_report_stat.date_start.should be_instance_of(Date)
          ad_report_stat.date_stop.should be_instance_of(Date)
        end
      end
    end
  end
end