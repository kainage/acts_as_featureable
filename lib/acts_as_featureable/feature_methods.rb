module ActsAsFeatureable
	module Feature
		def self.included(feature_model)
			feature_model.scope :ordered, ->{ order('position ASC') }
		end
	end
end