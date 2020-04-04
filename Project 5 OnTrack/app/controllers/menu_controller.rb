class MenuController < ApplicationController
  def index
  end

  def courses
    redirect_to :controller => 'data_scraper', :action => 'scrape'
  end 
end
