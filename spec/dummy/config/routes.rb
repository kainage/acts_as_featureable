Dummy::Application.routes.draw do
	resources :topics do
		resources :features
	end
end
