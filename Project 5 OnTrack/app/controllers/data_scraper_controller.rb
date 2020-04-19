# Created by Von Mbah on 2/26/20
# Goes through the course list and scrapes the data
# Modified: Jack Thompson - Fixed duplicates error
# Modified: Snigdha Tiwari - Added comments

class DataScraperController < ApplicationController
  def load
    # potentially for showing a loading spinner 
  end

  def scrape
    Rails.application.load_seed
    redirect_to controller: 'menu', action: 'index'
  end
end
