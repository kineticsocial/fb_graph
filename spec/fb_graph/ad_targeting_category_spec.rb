require 'spec_helper'

describe FbGraph::AdTargetingCategory, '.new' do
  it 'should setup all supported attributes' do
    attributes = {
	:id => 6008740787350, 
	:name => "Business and industry", 
	:type => "interests", 
	:path => ["Business and industry"], 
	:audience_size => 829803200
    }

    atc = FbGraph::AdTargetingCategory.new(attributes.delete(:id), attributes)
    atc.identifier.should == 6008740787350 
    atc.name.should == "Business and industry"
    atc.type.should == "interests"
    atc.path.should == ["Business and industry"]
    atc.audience_size == 829803200
  end
end

