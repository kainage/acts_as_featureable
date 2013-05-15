module ActsAsFeatureable
	module Feature
		def self.included(feature_model)
			feature_model.belongs_to :featureable, polymorphic: true
			
			feature_model.scope :ordered, ->{ feature_model.order('position ASC') }
			
			def feature_model.method_missing(meth, *args, &block)
				if ::ActsAsFeatureable.categories.include?(meth)
					self.scope meth, -> { self.where(category: meth) }
					self.send(meth)
				else
					super
				end
			end
			
			feature_model.send(:private, :method_missing)
		end
	end
end