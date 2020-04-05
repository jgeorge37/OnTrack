Rails.application.routes.draw do
  get 'recommendations/list'
  get 'recommendations/new'
  get 'recommendations/show'
  get 'recommendations/edit'
  get 'recommendations/destroy'
  root 'menu#index'
  get 'menu/index'
  post 'menu/index'
  get 'data_scraper/list'
  post 'data_scraper/scrape'
  get 'student_application/index'
  post 'student_application/index'
  get 'student_application/new'
  post 'student_application/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
