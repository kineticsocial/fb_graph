require 'spec_helper'

describe FbGraph::Connections::AdReportStats, '#ad_report_stats' do
  context 'when included by FbGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return ad_report_stats as FbGraph::AdReportStat' do
        mock_graph :get, 'act_12345566/reportstats', 'ad_accounts/ad_report_stats/test_ad_report_stats', :access_token => 'access_token' do
          ad_report_stats = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').ad_report_stats

          ad_report_stats.size.should == 2
          ad_report_stats.each { |ad_report_stat| ad_report_stat.should be_instance_of(FbGraph::AdReportStat) }
          ad_report_stats.first.should == FbGraph::AdReportStat.new(
            nil,
            :account_id => "12345566",
            :access_token => 'access_token'
          )
        end
      end
      
      it 'should return ad_report_stats as FbGraph::AdReportStat async' do
        mock_graph :post, 'act_12345566/reportstats', 'ad_accounts/ad_report_stats/test_ad_report_stats_async' do
          ad_report_stat = FbGraph::AdAccount.new('act_12345566', :access_token => 'access_token').ad_report_stats(:async => true)
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