Rails.application.routes.draw do
  devise_for :occupants, controllers: {
    registrations: "occupants/registrations"
  }
  devise_for :owners, controllers: {
    registrations: "owners/registrations"
  }
  root "pages#home"
end
