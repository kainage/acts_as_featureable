class Feature < ActiveRecord::Base
	include ActsAsFeatureable::Feature
	
	belongs_to :featureable, polymorphic: true
	
	after_create :assign_title, :assign_summary, :assign_position
		
	private
	
	def assign_title
		unless self.title
			self.title = featureable.title if featureable.respond_to?(:title)
		end
	end
	
	def assign_summary
		unless self.summary
			self.summary = featureable.summary if featureable.respond_to?(:summary)
		end
	end
	
	def assign_position
		# If there is no position given, or the position given is already taken,
		# assign the lowest open position. Otherwise assign it.
		all_positions = Feature.select('position').map(&:position).sort
		
		if !self.position || (self.position && all_positions.include?(self.position))
			# Find lowest, non-taken position
			
		end
	end
end