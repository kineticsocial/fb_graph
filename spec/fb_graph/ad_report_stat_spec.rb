require 'spec_helper'

describe FbGraph::AdReportStat, '.new' do
  it 'should setup supported attributes' do
    attributes = {
      :campaign_id => 6003266501234,
      :date_start => "2014-03-23",
      :date_stop => "2014-03-24",
      :time_start => 1349074800,
      :time_stop => "1349161200"
    }
    
    ad_report_stat = FbGraph::AdReportStat.new(nil, attributes)
    ad_report_stat.identifier.should == nil
    ad_report_stat.campaign_id == 6003266501234
    ad_report_stat.date_start.should == Date.parse("2014-03-23")
    ad_report_stat.date_stop.should == Date.parse("2014-03-24")
    ad_report_stat.time_start.should == Time.at(1349074800)
    ad_report_stat.time_stop.should == Time.at(1349161200)        
  end
end

describe FbGraph::AdReportStat, '.create' do
  it 'should setup supported attributes' do
    attributes = {
      :campaign_id => 6003266501234,
      :date_start => "2014-03-23",
      :date_stop => "2014-03-24",
      :time_start => 1349074800,
      :time_stop => "1349161200"
    }
    
    ad_report_stat = FbGraph::AdReportStat.new(nil, attributes)
    ad_report_stat.identifier.should == nil
    ad_report_stat.campaign_id == 6003266501234
    ad_report_stat.date_start.should == Date.parse("2014-03-23")
    ad_report_stat.date_stop.should == Date.parse("2014-03-24")
    ad_report_stat.time_start.should == Time.at(1349074800)
    ad_report_stat.time_stop.should == Time.at(1349161200)        
  end
end

describe FbGraph::AdReportStat, '.fetch' do
  it 'should get the status of the ad report' do
    mock_graph :get, '6018493043131', 'ad_report_stats/test_ad_report_stat_status', :access_token => 'access_token' do
      ad_report_stat = FbGraph::AdReportStat.fetch('6018493043131', :access_token => 'access_token')
      ad_report_stat.identifier.should == "6018493043131"
      ad_report_stat.async_status.should == "Job Completed"
      ad_report_stat.async_percent_completion.should == 100
    end
  end
end

describe FbGraph::AdReportStat, '#destroy' do
  it 'should request DELETE /:request_id' do
    mock_graph :delete, '6018493043131', 'true', :access_token => 'access_token' do
      FbGraph::AdReportStat.new('6018493043131', :access_token => 'access_token').destroy
    end
  end
end