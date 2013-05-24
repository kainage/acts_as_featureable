module ActsAsFeatureable
  # Set the maximum limit of features availible.
  mattr_accessor :feature_limit
  @@feature_limit = 10

  # Set the order of auto title assign
  mattr_accessor :auto_title_assign_list
  @@auto_title_assign_list = [:title, :name]

  # Set the order of auto summary assigning
  mattr_accessor :auto_summary_assign_list
  @@auto_summary_assign_list = [:summary, :caption, :tldr, :content, :text]

  # Limit the categories you wish to use.
  # This should be an array of symbols
  # [:main, :articles, :images]
  #
  # false allows unlimited categories.
  #
  # The benefit of using this is gaining the scopes for which categories you include.
  #
  # Feature.articles
  # => [<# Feature > ,<# Feature>]
  mattr_accessor :categories
  @@categories = false

  def self.setup
    yield self
  end
end