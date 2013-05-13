module ActsAsFeatureable
	module Feature
		def self.included(feature_model)
			feature_model.belongs_to :featureable, polymorphic: true
			
			feature_model.scope :ordered, ->{ feature_model.order('position ASC') }
		end
	end
end