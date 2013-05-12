class Feature < ActiveRecord::Base
	include ActsAsFeatureable::Feature
	
	belongs_to :featureable, polymorphic: true
end