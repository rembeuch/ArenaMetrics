Rails.application.routes.draw do
  resources :reservations, only: [:index]
  post :import, to: 'reservations#import'
  get :file, to: 'reservations#file'
  post :import_form, to: 'reservations#import_form'


  root "reservations#file"
end
  
 
