class MenuController < ApplicationController
  def index
    if !ClassName.any?
      redirect_to controller: 'data_scraper', action: 'scrape'
    elsif !Course.any?
      redirect_to controller: 'data_scraper', action: 'organize'
    end
  end
end
