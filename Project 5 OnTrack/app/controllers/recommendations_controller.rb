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
    # the commented out delete would only delete the last row regardless
    # uncommented delete is error
    #StudentRecommend.find_by(id: params[:id], sender_Id: 1)
    # @delete = StudentRecommend.find(params[:id])
    # if @delete.present?
    #   @delete.destroy
    # end
    @deleteRecommend.destroy
    respond_to do |format|
      format.html { redirect_to 'menu/index' ,notice: 'Delete recommendation successful'}
      format.json {head :no_content}
    end
    #Can you refresh page to depict changes in database table?
    # render 'menu/index'
      #redirect :back
  end


  private
    def find_recommendations
      @deleteRecommend = StudentRecommend.find(params[:id])
    end
    def user_params
      params.require(:recommend).permit(:student_fname, :student_lname, :student_lname_num, :teacher_fname, :teacher_lname,  :teacher_lname_num, :course, :course_section, :next_semester, :future_semester)
    end
end

