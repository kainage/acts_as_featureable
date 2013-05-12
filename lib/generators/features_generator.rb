require 'rails/generators/migration'

class FeaturesGenerator < Rails::Generators::Base
	include Rails::Generators::Migration
	
	source_root File.expand_path("../templates", __FILE__)
	
	def self.next_migration_number(path)
		Time.now.utc.strftime("%Y%m%d%H%M%S")
	end
	
	def create_featureable_file
		template "feature.rb", "app/models/feature.rb"
		migration_template "create_features.rb", "db/migrate/create_features.rb"
	end
end