class RecommendationsController < ApplicationController
  before_action :authenticate_teacher_user!
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
      # flash[:alert] = 'User was not saved.'
      #flash[:alert] = @recommend.errors
      # redirect to form page again
      render 'recommendations/new'
    end
  end

  def show
     # use @ symbols if you want to use it the view
    @allrecommend = StudentRecommend.all
  end

  def edit
    @recommend = StudentRecommend.find(params[:id])
    render 'edit'
  end

  def update
     @recommend = StudentRecommend.find(params[:id])
     if @recommend.update(user_params)
       redirect_to :action => 'show', notice: 'Successfully updated the evaluation'
     else
       redirect_to :action => 'show', notice: 'Error updating the evaluation'
     end
  end

  def destroy 
    # i would add checks, just in case
    delete = StudentRecommend.find(params[:id])
    delete.destroy
    redirect_to :action => 'show', notice: 'Delete recommendation successful'
  end


  private
    def user_params
      params.require(:recommend).permit(:student_fname, :student_lname, :student_lname_num, :teacher_fname, :teacher_lname,  :teacher_lname_num, :course, :course_section, :semester, :course_specification)
    end
end

