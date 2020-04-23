class EvaluationsController < ApplicationController
  def index
    @grader = Grader.all
    @rate = Array(1..5)
    @allevaluation = Evaluation.all
  end

  def new
    @rate = Array(1..5)
  end

  def create
    @rate = Array(1..5)
    @evaluation = Evaluation.new(user_params)
    if @evaluation.save
      flash[:notice] = 'Evaluation saved successfully'
      flash[:alert] = ''
      @allevaluation = Evaluation.all
      render 'evaluations/index'
    else
      #Saving failed, we can inspect @user.errors for more information
      flash[:alert] = 'User was not saved.'
      flash[:alert] = @evaluation.errors
      # redirect to form page again
      render '/'
    end
  end

  def show
    @rate = Array(1..5)
    @allevaluation = Evaluation.all
  end

  def destroy
    # i would add checks, just in case
    delete = Evaluation.find(params[:id])
    delete.destroy
    redirect_to :action => 'show', notice: 'Delete evaluation successful'
  end

  private
    def user_params
      params.require(:evaluation).permit(:instructor_fname, :instructor_lname, :instructor_name_dotnum, :grader_lname_dotnum, :course,  :quality, :punctuality, :com_skills, :course_knowledge)
    end

end
