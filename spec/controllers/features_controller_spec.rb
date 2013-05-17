require 'spec_helper'

describe FeaturesController do
	before :each do
		@topic = Topic.create!
	end

	# This should return the minimal set of attributes required to create a valid
	# Feature. As you add validations to Feature, be sure to
	# update the return value of this method accordingly.
	def valid_attributes
		{ "featureable_id" => @topic.id, "featureable_type" => 'Topic' }
	end

	# This should return the minimal set of values that should be in the session
	# in order to pass any filters (e.g. authentication) defined in
	# FeaturesController. Be sure to keep this updated too.
	def valid_session
		{}
	end

	describe "GET index" do
		it "assigns all features as @features" do
			feature = Feature.create! valid_attributes
			get :index, {:topic_id => @topic}, valid_session
			assigns(:features).should eq([feature])
			response.should be_success
			response.should render_template('index')
		end
	end

	describe "GET show" do
		it "assigns the requested feature as @feature" do
			feature = Feature.create! valid_attributes
			get :show, {:topic_id => @topic, :id => feature.to_param}, valid_session
			assigns(:feature).should eq(feature)
			response.should be_success
			response.should render_template('show')
		end
	end

	describe "GET new" do
		it "assigns a new feature as @feature" do
			get :new, {:topic_id => @topic}, valid_session
			assigns(:feature).should be_a_new(Feature)
			response.should be_success
			response.should render_template('new')
		end
	end

	describe "GET edit" do
		it "assigns the requested feature as @feature" do
			feature = Feature.create! valid_attributes
			get :edit, {:topic_id => @topic, :id => feature.to_param}, valid_session
			assigns(:feature).should eq(feature)
			response.should be_success
			response.should render_template('edit')
		end
	end

	describe "POST create" do
		describe "with valid params" do
			it "creates a new Feature" do
				expect {
					post :create, {:topic_id => @topic, :feature => valid_attributes}, valid_session
				}.to change(Feature, :count).by(1)
			end

			it "assigns a newly created feature as @feature" do
				post :create, {:topic_id => @topic, :feature => valid_attributes}, valid_session
				assigns(:feature).should be_a(Feature)
				assigns(:feature).should be_persisted
			end

			it "redirects to the created feature" do
				post :create, {:topic_id => @topic, :feature => valid_attributes}, valid_session
				response.should redirect_to @topic
			end
		end

		describe "with invalid params" do
			it "assigns a newly created but unsaved feature as @feature" do
			# Trigger the behavior that occurs when invalid params are submitted
				Feature.any_instance.stub(:save).and_return(false)
				post :create, {:topic_id => @topic, :feature => { "user_id" => "invalid value" }}, valid_session
				assigns(:feature).should be_a_new(Feature)
				assigns(:feature).should_not be_persisted
			end

			it "re-renders the 'new' template" do
			# Trigger the behavior that occurs when invalid params are submitted
				Feature.any_instance.stub(:save).and_return(false)
				post :create, {:topic_id => @topic, :feature => { "featureable_id" => "invalid value" }}, valid_session
				response.should redirect_to @topic
			end
		end
	end

	describe "PUT update" do
		describe "with valid params" do
			it "updates the requested feature" do
				feature = Feature.create! valid_attributes
				# Assuming there are no other features in the database, this
				# specifies that the Feature created on the previous line
				# receives the :update_attributes message with whatever params are
				# submitted in the request.
				Feature.any_instance.should_receive(:update).with({ "position" => "9" })
				put :update, {:topic_id => @topic, :id => feature.to_param, :feature => { "position" => "9" }}, valid_session
			end

			it "assigns the requested feature as @feature" do
				feature = Feature.create! valid_attributes
				put :update, {:topic_id => @topic, :id => feature.to_param, :feature => valid_attributes}, valid_session
				assigns(:feature).should eq(feature)
			end

			it "redirects to the featureable" do
				feature = Feature.create! valid_attributes
				put :update, {:topic_id => @topic, :id => feature.to_param, :feature => valid_attributes}, valid_session
				response.should redirect_to @topic
			end
		end

		describe "with invalid params" do
			it "assigns the feature as @feature" do
				feature = Feature.create! valid_attributes
				# Trigger the behavior that occurs when invalid params are submitted
				Feature.any_instance.stub(:save).and_return(false)
				put :update, {:topic_id => @topic, :id => feature.to_param, :feature => { "user_id" => "invalid value" }}, valid_session
				assigns(:feature).should eq(feature)
			end

			it "re-renders the 'edit' template" do
				feature = Feature.create! valid_attributes
				# Trigger the behavior that occurs when invalid params are submitted
				Feature.any_instance.stub(:save).and_return(false)
				put :update, {:topic_id => @topic, :id => feature.to_param, :feature => { "user_id" => "invalid value" }}, valid_session
				response.should redirect_to @topic
			end
		end
	end

	describe "DELETE destroy" do
		it "destroys the requested feature" do
			feature = Feature.create! valid_attributes
			expect {
				delete :destroy, {:topic_id => @topic, :id => feature.to_param}, valid_session
			}.to change(Feature, :count).by(-1)
		end

		it "redirects to the features list" do
			feature = Feature.create! valid_attributes
			delete :destroy, {:topic_id => @topic, :id => feature.to_param}, valid_session
			response.should redirect_to @topic
		end
	end

end
