# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_featureable/version'

Gem::Specification.new do |spec|
	spec.name          = "acts_as_featureable"
	spec.version       = ActsAsFeatureable::VERSION
	spec.authors       = ["Kainage"]
	spec.email         = ["kainage@gmail.com"]
	spec.description   = %q{Add a feature resource to a rails app}
	spec.summary       = %q{Creates a new polymorphic resrouce, Feature, for pulling content to a main/features page}
	spec.homepage      = "https://github.com/kainage/acts_as_featureable"
	spec.license       = "MIT"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_dependency "rails", "~> 4.0.0.rc1"

	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"
	spec.add_development_dependency "rspec"
	spec.add_development_dependency "sqlite3"
	spec.add_development_dependency "shoulda-matchers"
	spec.add_development_dependency "rspec-rails"
end
