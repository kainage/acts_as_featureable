class Feature < ActiveRecord::Base
	include ActsAsFeatureable::Feature
	
	before_validation :assign_title, :assign_summary, :assign_position
	
	validate :feature_limit_not_reached
	
	validates_numericality_of :position
		
	private
	
	def feature_limit_not_reached
		limit = ActsAsFeatureable.feature_limit
		errors.add(:base, 
			"The feature limit of #{limit} has been reached. \
			Please delete or change an existing feature."
		) if Feature.count >= limit
	end
	
	def assign_title
		# If there is no title given, check the model. 
		# Will check for the attributes in ActsAsFeatureable.auto_title_assign_list.
		
		unless self.title
			ActsAsFeatureable.auto_title_assign_list.each do |attr|
				if featureable.respond_to?(attr)
					self.title = featureable.send(attr)
					break
				end
			end
		end
	end
	
	def assign_summary
		# If there is no summary given, check the model. 
		# Will check for the attributes in ActsAsFeatureable.auto_summary_assign_list.
		
		unless self.summary
			ActsAsFeatureable.auto_summary_assign_list.each do |attr|
				if featureable.respond_to?(attr)
					self.summary = featureable.send(attr)
					break
				end
			end
		end
	end
	
	def assign_position
		# If there is no position given, or the position given is already taken,
		# assign the lowest open position. Otherwise assign it.
		all_positions = Feature.select('features.position').map(&:position).sort
		
		if !self.position || (self.position && all_positions.include?(self.position))
			# Find lowest, non-taken position
			(1..ActsAsFeatureable.feature_limit).each do |n|
				next if all_positions.include? n
				self.position = n
				break
			end
		end
	end
end