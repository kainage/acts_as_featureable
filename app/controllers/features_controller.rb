class FeaturesController < ApplicationController
	authorize_resource if defined?(CanCan::Ability)
	
	before_filter :find_featureable
	
	def index
		@features = Feature.all

		respond_to do |format|
			format.html 
			format.json { render json: @features }
		end
	end

	def show
		@feature = Feature.find(params[:id])

		respond_to do |format|
			format.html 
			format.json { render json: @feature }
		end
	end

	def new
		@feature = @featureable.features.build

		respond_to do |format|
			format.html
			format.json { render json: @feature }
		end
	end

	def edit
		@feature = Feature.find(params[:id])
		
		respond_to do |format|
			format.html
			format.json { render json: @feature }
		end
	end

	def create
		@feature = @featureable.features.build(feature_params)
		
		respond_to do |format|
			if @feature.save
				format.html { redirect_to @featureable, notice: 'Feature was successfully created.' }
				format.json { render json: @feature, status: :created, location: @feature }
			else
				format.html { redirect_to @featureable, alert: @feature.errors.full_messages.join(',') }
				format.json { render json: @feature.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def update
		@feature = Feature.find(params[:id])
		
		respond_to do |format|
			if @feature.update(feature_params)
				format.html { redirect_to @featureable, notice: 'Feature was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { redirect_to @featureable, alert: @feature.errors.full_messages.join(',') }
				format.json { render json: @feature.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@feature = Feature.find(params[:id])
		@feature.destroy

		respond_to do |format|
			format.html { redirect_to @featureable, notice: 'Feature was successfully removed.' }
			format.json { head :no_content }
		end
	end

	private
	
	def feature_params
		params.require(:feature).permit(:position, :category)
	end

	def find_featureable
		resource, id = request.path.split('/')[1, 2]
		@featureable = resource.singularize.classify.constantize.find(id)
	end
end
