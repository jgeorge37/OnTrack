Rails.application.routes.draw do
  root 'menu#index'
  get 'menu/index'
  post 'menu/index'
  get 'data_scraper/list'
  post 'data_scraper/scrape'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
