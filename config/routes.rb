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
  get "/sign_in", to: "pages#options"
end
