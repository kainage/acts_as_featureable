require 'rails/generators/migration'

class FeaturesGenerator < Rails::Generators::Base
	include Rails::Generators::Migration
	
	source_root File.expand_path("../templates", __FILE__)
	
	def self.next_migration_number(path)
		Time.now.utc.strftime("%Y%m%d%H%M%S")
	end
	
	def create_featureable_file
		copy_file "initializer.rb", "config/initializers/acts_as_featureable.rb"
		migration_template "create_features.rb", "db/migrate/create_features.rb"
	end
end