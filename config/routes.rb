Rails.application.routes.draw do
  resources :reservations
  post :import, to: 'reservations#import'
  get :file, to: 'reservations#file'

end
  
 
