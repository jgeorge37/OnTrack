class RecommendationsController < ApplicationController
  def list
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User saved successfully'
      #redirect_to 'elsewhere'
    else
      #Saving failed, we can inspect @user.errors for more information
      flash[:alert] = 'User was not saved.'
      # redirect to form page again
      redirect_to '/'
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end


  private
    def user_params
      params.require(:user).permit(:student_fname, :student_lname, :student_lname_num, :teacher_fname, :teacher_lname, :teacher_lname_num, :course)
    end
end

