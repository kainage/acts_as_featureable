module ActsAsFeatureable
  module FeatureAdditions
    def self.included(feature_model)
      feature_model.belongs_to :featureable, polymorphic: true

      feature_model.scope :ordered, ->{ feature_model.order('position ASC') }

      feature_model.before_validation :assign_title, :assign_summary, :assign_position

      feature_model.validate :feature_limit_not_reached, :ensure_categories

      feature_model.validates_presence_of :featureable_id, :featureable_type

      feature_model.validates_numericality_of :position

      private

      def ensure_categories
        cats = ::ActsAsFeatureable::categories
        # Allow all categories if set to false
        if cats && self.category && !cats.include?(self.category.to_sym)
          errors.add(:category, " is not in the list [#{cats.join(',')}]")
        end
      end

      def feature_limit_not_reached
        limit = ActsAsFeatureable.feature_limit
        errors.add(:base, %q{
          The feature limit of #{limit} has been reached. \
          Please delete or change an existing feature.
          }) if ActsAsFeatureable.categories ? Feature.where(category: self.category).count >= limit : Feature.count >= limit
      end

      def assign_title
        # If there is no title given, check the model.
        # Will check for the attributes in ActsAsFeatureable.auto_title_assign_list.
        unless self.title
          ActsAsFeatureable.auto_title_assign_list.each do |attr|
            if featureable.respond_to?(attr)
              self.title = featureable.send(attr)
              break
            end
          end
        end
      end

      def assign_summary
        # If there is no summary given, check the model.
        # Will check for the attributes in ActsAsFeatureable.auto_summary_assign_list.
        unless self.summary
          ActsAsFeatureable.auto_summary_assign_list.each do |attr|
            if featureable.respond_to?(attr)
              self.summary = featureable.send(attr)
              break
            end
          end
        end
      end

      def assign_position
        # If there is no position given, or the position given is already taken,
        # assign the lowest open position. Otherwise assign it.
        all_positions = if ActsAsFeatureable.categories
          Feature.select('features.position, features.category').where(category: self.category).map(&:position).sort
        else
          Feature.select('features.position').map(&:position).sort
        end

        if !self.position || (self.position && all_positions.include?(self.position))
          # Find lowest, non-taken position
          (1..ActsAsFeatureable.feature_limit).each do |n|
            next if all_positions.include? n
            self.position = n
            break
          end
        end
      end

      def feature_model.method_missing(mehtod_name, *args, &block)
        if ActsAsFeatureable.categories &&
            ActsAsFeatureable.categories.include?(mehtod_name)
          self.scope mehtod_name, -> { self.where(category: mehtod_name) }
          self.send(mehtod_name)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        (ActsAsFeatureable.categories &&
            ActsAsFeatureable.categories.include?(method_name)) ||
          super
      end
    end
  end
end