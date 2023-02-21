Rails.application.routes.draw do
  root "pages#home"

  devise_for :occupants, controllers: {
    registrations: "occupants/registrations",
    sessions: "occupants/sessions"
  }
  devise_for :owners, controllers: {
    registrations: "owners/registrations",
    sessions: "owners/sessions"
  }
  
  resources :rooms
  
  get "locations/new", to: "locations#new", as: "new_location"
  post "locations", to: "locations#create"
  delete "locations/:id", to: "locations#destroy", as: "location"
  get "locations/select-barangay", to: "locations#select_barangay", as: "select_barangay"
  get "/sign_in", to: "pages#options"

  post "room/:room_id/reviews", to: "reviews#create", as: "room_reviews"
  get "room/:room_id/reviews/:review_id/edit", to: "reviews#edit", as: "edit_room_review"
  patch "room/:room_id/reviews/:review_id", to: "reviews#update", as: "room_review"
  delete "room/:room_id/reviews/:review_id", to: "reviews#destroy"

  get "dashboard", to: "pages#dashboard", as: "dashboard"
  get "map/:location_id", to: "pages#map", as: "map"
end
