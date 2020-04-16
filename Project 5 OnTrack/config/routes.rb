Rails.application.routes.draw do
  devise_for :users
  get 'admin_panel/index'
  post 'admin_panel/index'
  get 'admin_panel/modify'
  get 'data_scraper/organize'
  post 'data_scraper/organize'
  get 'data_scraper/load'
  post 'data_scraper/load'
  get 'configuraton/index'
  post 'configuration/index'
  get 'recommendations/list'
  get 'recommendations/new'
  get 'recommendations/show'
  get 'recommendations/edit'
  get 'recommendations/destroy'
  root 'menu#index'
  get 'menu/index'
  post 'menu/index'
  get 'data_scraper/scrape'
  post 'data_scraper/scrape'
  get 'student_application/index'
  post 'student_application/index'
  get 'student_application/new'
  post 'student_application/new'
  get 'student_application/create'
  post 'student_application/create'

  # Added for testing recommendation form
  #get '/' =>'recommendations#new'
  post 'recommendations/new'
  post '/' => 'recommendations#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
