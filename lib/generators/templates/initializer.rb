ActsAsFeatureable.setup do |config|
  # Set the maximum limit of features availible for your app.
  config.feature_limit = 10

  # Set the order of auto title assigning.
  config.auto_title_assign_list = [:title, :name]

  # Set the order of auto summary assigning.
  config.auto_summary_assign_list = [:summary, :caption, :tldr, :content, :text]

  # Limit the categories you wish to use.
  # => [:main, :articles, :images]
  # false allows unlimited categories.
  config.categories = false
end
