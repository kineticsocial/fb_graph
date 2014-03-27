require 'spec_helper'

describe FbGraph::AdInterestValid, '.search' do
  it 'should perform a search' do
    mock_graph :get, 'search', 'ad_interest_valids/movie_valid', :params => {:type => 'adinterestvalid', :interest_list => "Fantasy film"} do

      valid_results = FbGraph::AdInterestValid.search("Fantasy film")

      valid_results.size.should == 1
      valid_results.first.should be_instance_of(FbGraph::AdInterestValid)
      valid_results.first.should be_valid
      valid_results.first.name.should == "Fantasy film"
      valid_results.first.audience_size.should == 168548344
      valid_results.first.path.should be_blank
    end
  end
end
