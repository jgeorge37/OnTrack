class RecommendationsController < ApplicationController
  def list
  end

  def new
  end

  def create
    @recommend = StudentRecommend.new(user_params)
    if @recommend.save
      flash[:notice] = 'User saved successfully'
      flash[:alert] = ''
      @allrecommend = StudentRecommend.all
      render 'recommendations/show'
    else
      #Saving failed, we can inspect @user.errors for more information
      flash[:alert] = 'User was not saved.'
      flash[:alert] = @recommend.errors
      # redirect to form page again
      render '/'
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
      params.require(:recommend).permit(:student_fname, :student_lname, :student_lname_num, :teacher_fname, :teacher_lname,  :teacher_lname_num, :course, :course_section, :next_semester, :future_semester)
    end
end

