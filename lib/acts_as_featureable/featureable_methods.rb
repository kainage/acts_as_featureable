module ActiveRecord
	module Acts
		module Featureable
			def self.included(base)
				base.extend ClassMethods
			end
			
			module ClassMethods
				def acts_as_featureable
					has_many :features, :as => :featureable, :dependent => :destroy
				end
			end
		end
	end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Featureable)