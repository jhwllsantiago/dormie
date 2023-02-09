Rails.application.routes.draw do
  devise_for :occupants
  devise_for :owners
  root "pages#home"
end
