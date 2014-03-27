require 'spec_helper'

describe FbGraph::AdInterest, '.search' do
  it 'should perform a search' do
    mock_graph :get, 'search', 'ad_interests/movie_search', :params => {:q => 'movie', :type => 'adinterest'} do
      ad_interests = FbGraph::AdInterest.search('movie')

      ad_interests.size.should == 8
      ad_interests.each {|kw| kw.should be_instance_of(FbGraph::AdInterest)}
      ad_interests.first.should == FbGraph::AdInterest.new(
        6002994410168,
	{
        :name => "Film",
	:audience_size => 58104052,
	:path => [],
        :description => ""
	}
      )
    end
  end
end

