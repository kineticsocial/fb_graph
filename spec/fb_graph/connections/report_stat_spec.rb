require 'spec_helper'

describe FbGraph::Connections::AdCampaigns, '#report_stat!' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should create report_stat asyncronized request as FbGraph::ReportStat' do        
        mock_graph :post, 'act_12345566/reportstats', 'ad_accounts/report_stats/test_report_stats_async', :params => {
          :async => "true",
          :date_preset => "last_week",
          :data_columns => "[\"adgroup_id\",\"actions\",\"spend\"]"
        }, :access_token => 'access_token' do
          options = {:date_preset => :last_week, :data_columns => [:adgroup_id, :actions, :spend]}
          report_stat = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').report_stat!(options)
          report_stat.should be_instance_of(FbGraph::ReportStat)
          report_stat.should == FbGraph::ReportStat.new(
            6018478973531,
            :access_token => 'access_token'
          )
        end
      end
    end
  end
end
  
describe FbGraph::Connections::ReportStats, '#report_stats' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return report_stats as FbGraph::ReportStat' do
        mock_graph :get, 'act_12345566/reportstats?data_columns=["adgroup_id","actions","spend"]&date_preset=last_week', 'ad_accounts/report_stats/test_report_stats', :access_token => 'access_token' do
          options = {
            :date_preset => :last_week,
            :data_columns => [:adgroup_id, :actions, :spend]
          }
          report_stats = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').report_stats(options)

          report_stats.size.should == 2
          report_stats.each { |report_stat| report_stat.should be_instance_of(FbGraph::ReportStat) }
          report_stat = report_stats.first
          report_stat.should == FbGraph::ReportStat.new(
            nil,
            :adgroup_id => 6018408642331,
            :date_start => "2014-03-20",
            :date_stop => "2014-03-20",
            :actions => 3,
            :spend => 1.5,
            :access_token => 'access_token'
          )
          
          report_stat.date_start.should be_instance_of(Date)
          report_stat.date_stop.should be_instance_of(Date)
        end
      end
      
      it 'should return asyncronized report_stats as FbGraph::ReportStat' do
        mock_graph :get, 'act_12345566/reportstats?report_run_id=6018494456931', 'ad_accounts/report_stats/test_report_stats_async_results', :access_token => 'access_token' do
          options = {
            :report_run_id => 6018494456931
          }
          report_stats = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').report_stats(options)

          report_stats.size.should == 2
          report_stats.each { |report_stat| report_stat.should be_instance_of(FbGraph::ReportStat) }
          report_stat = report_stats.first
          report_stat.should == FbGraph::ReportStat.new(
            nil,
            :adgroup_id => 6018408642331,
            :date_start => "2014-03-20",
            :date_stop => "2014-03-20",
            :actions => 3,
            :spend => 1.5,
            :access_token => 'access_token'
          )
          
          report_stat.date_start.should be_instance_of(Date)
          report_stat.date_stop.should be_instance_of(Date)
        end
      end
    end
  end
end