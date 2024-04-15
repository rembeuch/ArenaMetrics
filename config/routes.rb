Rails.application.routes.draw do
  resources :reservations, only: [:index]
  post :import, to: 'reservations#import'
  get :file, to: 'reservations#file'

  root "reservations#file"
end
  
 
