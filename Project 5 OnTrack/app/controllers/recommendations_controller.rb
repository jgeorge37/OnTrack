class RecommendationsController < ApplicationController
  $editUser
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
      render 'recommendations/show'
    end
  end

  def show
     # use @ symbols if you want to use it the view
    @allrecommend = StudentRecommend.all
  end

  def edit
    #flash[:alert] = params[:fname]
    $editUser = StudentRecommend.find_by(student_fname: params[:fname], student_lname: params[:lname], student_lname_num: params[:num])
    flash[:alert] = $editUser.student_fname

    render 'edit'
  end

  def update
    #flash[:alert] = params[:fname]
      #$editUser = StudentRecommend.find_by(student_fname: params[:fname], student_lname: params[:lname], student_lname_num: params[:num])
    # if $editUser.update(user_params)
       redirect_to :action => 'show', notice: 'Edit recommendation successful'
    # end
  end

  def destroy 
    # i would add checks, just in case
    delete = StudentRecommend.find(params[:id])
    delete.destroy
    redirect_to :action => 'show', notice: 'Delete recommendation successful'
  end


  private
    # def find_recommendations
    #   @deleteRecommend = StudentRecommend.find(params[:id])
    # end
    def user_params
      params.require(:recommend).permit(:student_fname, :student_lname, :student_lname_num, :teacher_fname, :teacher_lname,  :teacher_lname_num, :course, :course_section, :next_semester, :future_semester)
    end
end

