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
  get "rooms/:id/images", to: "rooms#images", as: "room_images"
  
  get "locations/new", to: "locations#new", as: "new_location"
  post "locations", to: "locations#create"
  delete "locations/:id", to: "locations#destroy", as: "location"
  get "/sign_in", to: "pages#options"

  post "room/:room_id/reviews", to: "reviews#create", as: "room_reviews"
  get "room/:room_id/reviews/:review_id/edit", to: "reviews#edit", as: "edit_room_review"
  patch "room/:room_id/reviews/:review_id", to: "reviews#update", as: "room_review"
  delete "room/:room_id/reviews/:review_id", to: "reviews#destroy"

  get "dashboard", to: "pages#dashboard", as: "dashboard"

  get "maps/render/location/:location_id", to: "maps#location_map", as: "location_map"
  get "maps/marker", to: "maps#marker_map", as: "marker_map"
  get "maps/results", to: "maps#results_map", as: "results_map"

  devise_scope :owner do
    get "owners", to: "owners/registrations#edit"
    get "owners/password", to: "owners/passwords#new"
  end

  devise_scope :occupant do
    get "occupants", to: "occupants/registrations#edit"
    get "occupants/password", to: "occupants/passwords#new"
  end
end
