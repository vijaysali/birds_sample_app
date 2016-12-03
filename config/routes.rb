Rails.application.routes.draw do
  api_version(:module => "API::V1", :path => {:value => "v1"}, :default => true) do
    resources :birds
  end
end
