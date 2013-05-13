require 'acts_as_featureable/version'
require 'acts_as_featureable/featureable_methods'
require 'acts_as_featureable/feature_methods'
require 'acts_as_featureable/feature'

module ActsAsFeatureable
	# Set the maximum limit of features availible.
	mattr_accessor :feature_limit
	@@feature_limit = 10
	
	# Set the order of auto title assign
	mattr_accessor :auto_title_assign_list
	@@auto_title_assign_list = [:title, :name]
	
	# Set the order of auto summary assigning
	mattr_accessor :auto_summary_assign_list
	@@auto_summary_assign_list = [:summary, :caption, :tldr, :content, :text]
	
	def self.setup
		yield self
	end
end