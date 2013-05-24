module FeaturesHelper
  def feature_form_for(featureable)
    render 'features/form', :featureable => featureable
  end

  def features_for(featureable)
    render 'features/features', :featureable => featureable
  end
end