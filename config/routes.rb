Rails.application.routes.draw do
  namespace "api" do
    resources :patients do
      resources :recommendations, only: :index
    end
    resources :consultation_requests do
      resources :recommendations, only: [:index, :create]
    end
    resources :recommendations, only: :index
    get "/external_api/:endpoint/:data", to: "external_api#index"
  end
end
