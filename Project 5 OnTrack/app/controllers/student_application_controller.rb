class StudentApplicationController < ApplicationController
    def index 

    end

    def new
        @classNames = ClassName.all
        @teachings = Teaching.all
        response = { :classNames => @classNames, :teachings => @teachings}
        respond_to do |format|
            format.html { render :new }
            format.json { render :json => response }
        end
    end

    def create 

    end
end
