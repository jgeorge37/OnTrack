class StudentApplicationController < ApplicationController
    def index 

    end

    def new
        @classNames = ClassName.all
    end

    def create 

    end
end
