class StudentApplicationController < ApplicationController
    def index 

    end

    def new
        @classNames = ClassName.all
        respond_to do |format|
            format.html { render :new }
            format.json { render :json => @classNames.to_json }
        end
    end

    def create 

    end
end
