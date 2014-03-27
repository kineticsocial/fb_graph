require 'spec_helper'

describe FbGraph::AdInterestSuggestion, '.search' do
  it 'should perform a search' do
    mock_graph :get, 'search', 'ad_interest_suggestions/movie_suggestions', :params => {:interest_list => 'Fantasy film', :type => 'adinterestsuggestion'} do
      ad_interests = FbGraph::AdInterestSuggestion.search('Fantasy film')

      ad_interests.size.should == 15
      ad_interests.each {|kw| kw.should be_instance_of(FbGraph::AdInterestSuggestion)}
      ad_interests.first.should == FbGraph::AdInterestSuggestion.new(
	6003535157273,
        :name => "Adventure film",
	:audience_size => 160284075, 
        :path => [], 
        :description => ""
      )
    end
  end
end
