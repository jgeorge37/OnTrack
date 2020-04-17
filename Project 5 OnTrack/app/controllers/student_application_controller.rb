class StudentApplicationController < ApplicationController
    def index
        @grader = Grader.all
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
        @grader = Grader.new(name: params[:fname] + " " + params[:lname], last_name_dot: params[:lname_dot], gpa: params[:gpa]);
        if @grader.save
            if params.has_key?(:course) then
                newParams = params.require(:course).permit!
                newParams[:course] do |k, v|
                    @className = ClassName.find_by(name: key)
                    @completedCourse = GraderCompletedCourse.create(grader_id: @grader.id, course_id: @className.id, grade: key[:grade])
                    key[:time].each do |t|
                        @graderTimeAvailability = GraderTimeAvailability.create(grader_completed_course_id: @completedCourse.id, time: t)
                    end
                end
            end
            if params.has_key?(:gradeCourse) then 
                params[:gradedCourse].each do |c|
                    @className = ClassName.find_by(name: c)
                    @gradedPreviousCourse = GraderPreviousGradeCourse.create(grader_id: @grader.id, course_id: @className.id)
                end
            end
            redirect_to "/student_application/index", note: 'Succcessfully submitted application'
        else
            render "/student_application/index"
        end
    end

    def edit

    end

    def update

    end

end
