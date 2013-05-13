# Acts As Featureable

[![Build Status](https://travis-ci.org/kainage/acts_as_featureable.png)](https://travis-ci.org/kainage/acts_as_featureable)

Requires ruby *1.9.3* or later

Add a polymorphic resource to your rails app for pulling content to a main/features page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_featureable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_featureable
    
Run the generator:

    $ rails g features

This will create the migration file and an initializer.

Migrate the database:

    $ rake db:migrate

## Configuration

Edit the initializer file to set default settings for feature size and auto title & summary assigning:

## Usage

### Featureable Model

Add the appropriate line to the class you want to feature:

```ruby
class Topic
	acts_as_featurable
end
```

### Creating Features

Add a feature to a model. The _title_ and _summary_ (or whichever methods you add in the initializer file) will be assigned:

```ruby
featureable = Topic.create(title: 'Title', summary: 'Summary')
featureable.features.create
#<Feature title: "Title", summary: "Summary">
```

You can also override them directly:

```ruby
featureable = Topic.create(title: 'Title', summary: 'Summary')
featureable.features.create(title: 'My New Title', summary 'My New Summary')
#<Feature title: "My New Title", summary: "My New Summary">
```

The _position_ of the features can be specified:

```ruby
featureable = Topic.create
featureable.features.create(position: 3)
#<Feature position: 3>
```

If it is not specified, it will automatically be assigned the next, lowest _position_:

```ruby
featureable = Topic.create
featureable.features.create
#<Feature position: 1>

featureable.features.create
#<Feature position: 2>
```

If you try and assign a position which has already been taken, it will find the next, lowest available _position_:

```ruby
featureable = Topic.create
featureable.features.create
#<Feature position: 1>

featureable.features.create(position: 1)
#<Feature position: 2>

featureable.features.create(position: 1)
#<Feature position: 3>
```

### Feature scope

Get all features ordered by thier _position_ ascending:

```ruby
Feature.ordered
```

Implementing the forms and views is left up to the developer.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
