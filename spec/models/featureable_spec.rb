require 'spec_helper'

describe Topic do
	subject { Topic.create! }
	
	it { should be_valid }
	it { should have_many :features }
end
