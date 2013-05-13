require 'spec_helper'

describe Feature do
	before :each do
		Feature.delete_all
	end
	
	subject { Feature.create! }
	
	it { should be_valid }
	it { should belong_to :featureable }
	it { should validate_numericality_of :position }
	
	## LIMIT VALIDATION ##
	it "should only allow the default number of features to be made" do
		limit = ActsAsFeatureable.feature_limit
		
		# Create the limit of features
		limit.times do 
			Feature.create!
		end
		
		# Attempt to create an additional feature
		expect { Feature.create! }.to raise_error ActiveRecord::RecordInvalid
	end
	
	## TITLE ##
	it "should assign associated model's title" do
		@topic = Topic.new(:title => 'Title')
		feature = Feature.create!(:featureable => @topic)
		
		feature.title.should eql @topic.title
	end
	
	it "should overwrite associated model's title" do
		@topic = Topic.new(:title => 'Title')
		feature = Feature.create!(:featureable => @topic, :title => 'New Title')
		
		feature.title.should eql 'New Title'
	end
	
	## SUMMARY ##
	it "should assign associated model's summary" do
		@topic = Topic.new(:summary => 'Summary')
		feature = Feature.create!(:featureable => @topic)
		
		feature.summary.should eql @topic.summary
	end
	
	it "should overwrite associated model's summary" do
		@topic = Topic.new(:summary => 'Summary')
		feature = Feature.create!(:featureable => @topic, :summary => 'New Summary')
		
		feature.summary.should eql 'New Summary'
	end
	
	## POSITION ##
	it "should assign a default position" do
		subject.position.should_not be_nil
	end
	
	it "should assign a default position of 1 if there are none existing" do
		subject.position.should eql 1
	end
	
	it "should assign the next position in line if it already exists" do
		subject
		Feature.create!(:position => 1).position.should eql 2
	end
end
	