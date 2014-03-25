require 'spec_helper'

describe FbGraph::ReportStat, '.new' do
  it 'should setup supported attributes' do
    attributes = {
      :campaign_id => 6003266501234,
      :date_start => "2014-03-23",
      :date_stop => "2014-03-24",
      :time_start => 1349074800,
      :time_stop => "1349161200"
    }
    
    report_stat = FbGraph::ReportStat.new(nil, attributes)
    report_stat.identifier.should == nil
    report_stat.campaign_id == 6003266501234
    report_stat.date_start.should == Date.parse("2014-03-23")
    report_stat.date_stop.should == Date.parse("2014-03-24")
    report_stat.time_start.should == Time.at(1349074800)
    report_stat.time_stop.should == Time.at(1349161200)        
  end
end

describe FbGraph::ReportStat, '.create' do
  it 'should setup supported attributes' do
    attributes = {
      :campaign_id => 6003266501234,
      :date_start => "2014-03-23",
      :date_stop => "2014-03-24",
      :time_start => 1349074800,
      :time_stop => "1349161200"
    }
    
    report_stat = FbGraph::ReportStat.new(nil, attributes)
    report_stat.identifier.should == nil
    report_stat.campaign_id == 6003266501234
    report_stat.date_start.should == Date.parse("2014-03-23")
    report_stat.date_stop.should == Date.parse("2014-03-24")
    report_stat.time_start.should == Time.at(1349074800)
    report_stat.time_stop.should == Time.at(1349161200)        
  end
end

describe FbGraph::ReportStat, '.fetch' do
  it 'should get the status of the ad report' do
    mock_graph :get, '6018493043131', 'report_stats/test_report_stat_status', :access_token => 'access_token' do
      report_stat = FbGraph::ReportStat.fetch('6018493043131', :access_token => 'access_token')
      report_stat.identifier.should == "6018493043131"
      report_stat.async_status.should == "Job Completed"
      report_stat.async_percent_completion.should == 100
    end
  end
end

describe FbGraph::ReportStat, '#destroy' do
  it 'should request DELETE /:request_id' do
    mock_graph :delete, '6018493043131', 'true', :access_token => 'access_token' do
      FbGraph::ReportStat.new('6018493043131', :access_token => 'access_token').destroy
    end
  end
end