Rails.application.routes.draw do
  get "about/about"
  root "static_pages#home"
  get "static_pages/help"
  get "static_pages/home"
end
