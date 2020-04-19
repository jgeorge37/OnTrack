class MenuController < ApplicationController
  def index
    if !ClassName.any? then redirect_to controller: 'data_scraper', action: 'scrape' end
  end
end
