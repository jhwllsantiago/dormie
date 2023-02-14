Rails.application.routes.draw do
  devise_for :occupants, controllers: {
    registrations: "occupants/registrations",
    sessions: "occupants/sessions"
  }
  devise_for :owners, controllers: {
    registrations: "owners/registrations",
    sessions: "owners/sessions"
  }
  root "pages#home"

  resources :rooms
  get "locations/new", to: "locations#new"
  post "locations", to: "locations#create"
  get "locations/select-barangay", to: "locations#select_barangay", as: "select_barangay"
  get "/sign_in", to: "pages#options"
end
