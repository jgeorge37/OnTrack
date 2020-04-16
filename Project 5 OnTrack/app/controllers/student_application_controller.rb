class StudentApplicationController < ApplicationController
    def index

    end

    def new
        @classNames = ClassName.all
        @teachings = Teaching.all
        @descriptions = Description.all
        @meetings = Meeting.all
        response = { :classNames => @classNames, :teachings => @teachings,
             :descriptions => @descriptions, :meetings => @meetings}
        respond_to do |format|
            format.html { render :new }
            format.json { render :json => response }
        end
    end

    def create
    end
end
