require 'active_record'
require 'shoulda-matchers'
require 'acts_as_featureable'

ActiveRecord::Base.establish_connection(
	:adapter => "sqlite3",
	:database => ":memory:"
)

load(File.dirname(__FILE__) + '/extra/schema.rb')
load(File.dirname(__FILE__) + '/extra/model.rb')