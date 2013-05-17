require 'spec_helper'

describe FeaturesHelper do
	before :each do
		@topic = Topic.create!
	end
	
	describe "features_form_for" do
		it "should render the form for a new feature" do
			helper.feature_form_for(@topic).should =~ /id="new_feature"/
		end
	end
	
	describe "features_for" do
		it "should be empty if there are no features for the featureable" do
			helper.features_for(@topic).should be_blank
		end
		
		it "should render a list of features" do
			@topic.features.create!
			helper.features_for(@topic).should =~ /class="feature"/
		end
	end
end