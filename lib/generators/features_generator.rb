require 'rails/generators/migration'

class FeaturesGenerator < Rails::Generators::Base
	include Rails::Generators::Migration
	
	source_root File.expand_path("../templates", __FILE__)
	
	def create_featureable_file
		template "feature.rb", "app/models/feature.rb"
		migration_template "create_features.rb", "db/migrate/create_features.rb"
	end
end