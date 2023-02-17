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

  post "room/:room_id/reviews", to: "reviews#create", as: "room_reviews"
  get "room/:room_id/reviews/:review_id/edit", to: "reviews#edit", as: "edit_room_review"
  patch "room/:room_id/reviews/:review_id", to: "reviews#update", as: "room_review"
  delete "room/:room_id/reviews/:review_id", to: "reviews#destroy"
end
