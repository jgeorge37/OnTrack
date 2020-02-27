Rails.application.routes.draw do
  root 'data_scraper#scrape'
  get 'data_scraper/list'
  get 'data_scraper/scrape'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
