require 'spec_helper'

describe Feature do
  before :each do
    Feature.delete_all
    @topic = Topic.create!
  end

  subject { @topic.features.create! }

  it { should be_valid }
  it { should belong_to :featureable }
  it { should validate_numericality_of :position }
  it { should validate_presence_of :featureable_id }
  it { should validate_presence_of :featureable_type }

  ## ENSURE CATEGORIES ##
  it "should allow any categories by default" do
    @topic.features.create!(category: 'anything').errors.count.should eql 0
  end

  describe "with category limits" do
    before :each do
      ActsAsFeatureable.categories = [:default]
    end

    it "should allow a category that is in the list" do
      @topic.features.create(category: :default).errors.count.should eq 0
    end

    it "should not allow a category that is not in the list" do
    	feature = @topic.features.create(category: :foo)

      feature.errors.count.should eq 1
      feature.errors.messages.keys.should include(:category)
    end

    ## CREATE SCOPES ##
    it "should create scopes for the default categories" do
      Feature.default
    end

    it "should return all the features of the scope for the deafult categories" do
      @topic.features.create!(category: :default)

      Feature.default.size.should eq 1
    end
  end

  ## LIMIT VALIDATION ##
  it "should only allow the default number of features to be made" do
    # Create the limit of features
    ActsAsFeatureable.feature_limit.times do
      @topic.features.create!
    end

    # Attempt to create an additional feature
    expect { @topic.features.create! }.to raise_error ActiveRecord::RecordInvalid
  end

  describe "with category limits" do
    before :each do
      ActsAsFeatureable.categories = [:one, :two]

    	# Create the limit of features
      ActsAsFeatureable.feature_limit.times do
        @topic.features.create!(category: :one)
      end
    end

    it "should only allow the default number of features per category to be made" do
      # Attempt to create an additional feature
      expect { @topic.features.create!(category: :one) }.to raise_error ActiveRecord::RecordInvalid
    end

    it "should allow more features to be made of other categories when one is full" do
      expect { @topic.features.create!(category: :two) }.to_not raise_error ActiveRecord::RecordInvalid
    end
  end

  ## TITLE ##
  describe "with featureable" do
    before :each do
      @topic = Topic.create!(:title => 'Title')
    end

    it "should assign associated model's title" do
      feature = @topic.features.create!(:featureable => @topic)

      feature.title.should eql @topic.title
    end

    it "should overwrite associated model's title" do
      feature = @topic.features.create!(:featureable => @topic, :title => 'New Title')

      feature.title.should eql 'New Title'
    end

    ## SUMMARY ##
    it "should assign associated model's summary" do
      feature = @topic.features.create!(:featureable => @topic)

      feature.summary.should eql @topic.summary
    end

    it "should overwrite associated model's summary" do
      feature = @topic.features.create!(:featureable => @topic, :summary => 'New Summary')

      feature.summary.should eql 'New Summary'
    end
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
    @topic.features.create!(:position => 1).position.should eql 2
  end
end
