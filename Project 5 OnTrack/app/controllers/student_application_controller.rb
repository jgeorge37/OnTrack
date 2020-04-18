class StudentApplicationController < ApplicationController
    def index
        @grader = Grader.all
    end

    def show
        @classNames = ClassName.all
        @grader = Grader.find(params[:id])
        @completedCourses = Array(GraderCompletedCourse.where(grader_id: params[:id]))
        @previousCourses = Array(GraderPreviousGradeCourse.where(grader_id: params[:id]))
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
                params[:course].each do |key, value|
                    @className = ClassName.find_by(name: key)
                    @completedCourse = GraderCompletedCourse.create(grader_id: @grader.id, course_id: @className.id, grade: value[:grade])
                    value[:time].each do |t|
                        @graderTimeAvailability = GraderTimeAvailability.create(grader_completed_course_id: @completedCourse.id, time: t)
                    end
                end
            end
            puts params.has_key?(:gradedCourse)
            if params.has_key?(:gradedCourse) then 
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
        @grader = Grader.find(params[:id]);
        @completedCourses = GraderCompletedCourse.where(grader_id: params[:id])
        @previousCourses = GraderPreviousGradeCourse.where(grader_id: params[:id])
        @classNames = ClassName.all
        @teachings = Teaching.all
        @descriptions = Description.all
        @meetings = Meeting.all
        response = { :classNames => @classNames, :teachings => @teachings,
             :descriptions => @descriptions, :meetings => @meetings}
        respond_to do |format|
            format.html 
            format.json { render :json => response }
        end
    end

    def update

    end

    def delete
        @grader = Grader.find(params[:id])
    
        @previousCourses = Array(GraderPreviousGradeCourse.find_by(grader_id: params[:id]))
        @previousCourses.each do |p|
            p.destroy
        end
        @completedCourses = Array(GraderCompletedCourse.find_by(grader_id: params[:id]))
        
        @completedCourses.each do |c|
            @time = Array(GraderTimeAvailability.find_by(grader_completed_course_id: c.id))
            @time.each do |t|
                t.destroy
            end
            c.destroy
        end
        @grader.destroy
        redirect_to "student_application/index"
    end

end
