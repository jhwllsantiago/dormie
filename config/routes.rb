Rails.application.routes.draw do
  devise_for :owners
  root "pages#home"
end
