Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'benchmark#hello_world'
  get '/simulated_io', to: 'benchmark#simulated_io'
end
