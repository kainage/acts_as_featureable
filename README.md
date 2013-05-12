# Acts As Featureable

Add a polymorphic resource to your rails app for pulling content to a main/features page.

## Installation

Add this line to your application's Gemfile:

    gem 'acts_as_featureable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_featureable
    
Run the generator

		rails g features
		
Migrate the database

		rake db:migrate

## Usage

Add the line acts_as_featurable to the class you want to feature.

		class Topic
			acts_as_featurable
		end

Make sure the class you are making featureable has the methods 'title' and 'summary'

Add a feature to a model. The 'title' and 'summary' will be pulled from the model
unless you specify otherwise and only if the corresponding reader methods exist.

		featureable = Topic.create
		featureable.features.create # will have title and summary of the Topic

or

		featureable = Topic.create
		featureable.features.create(title: 'My New Title', summary 'Short description here')
		
Get all features by thier position

		Feature.ordered

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
