class EvaluationsController < ApplicationController
  before_action :authenticate_teacher_user!
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
      # redirect to form page again
      render 'evaluations/new'
    end
  end

  def edit
    @rate = Array(1..5)
    @evaluation = Evaluation.find(params[:id])
  end

  def update
    @evaluation = Evaluation.find(params[:id])
    if @evaluation.update(user_params)
      if @evaluation.save
        redirect_to :action => 'index', notice: 'Sucessfully updated the evaluation'
      end
    else
      redirect_to :action => 'index', notice: 'Error updating the evaluation'
    end
  end

  def show
    @rate = Array(1..5)
    @allevaluation = Evaluation.all
  end

  def destroy
    delete = Evaluation.find(params[:id])
    delete.destroy
    redirect_to :action => 'index', notice: 'Deleted evaluation successfully'
  end

  private
    def user_params
      params.require(:evaluation).permit(:instructor_fname, :instructor_lname, :instructor_name_dotnum, :grader_lname_dotnum, :course,  :quality, :punctuality, :com_skills, :course_knowledge)
    end

end
