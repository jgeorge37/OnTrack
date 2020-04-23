class StudentApplicationController < ApplicationController
    before_action :authenticate_user!
    def index
        @grader = Grader.all
        @notice = params[:notice]
        @alert = params[:alert]
    end

    def show
        @classNames = ClassName.all
        @grader = Grader.find(params[:id])
        @completedCourses = Array(GraderCompletedCourse.where(grader_id: params[:id]))
        @previousCourses = Array(GraderPreviousGradeCourse.where(grader_id: params[:id]))
    end

    def new
        @alert = params[:alert]
        @classNames = ClassName.all
        @teachings = Teaching.all
        @courses = Course.all
        @meetings = Meeting.all
        response = { :classNames => @classNames, :teachings => @teachings,
             :course => @courses, :meetings => @meetings}
        respond_to do |format|
            format.html { render :new }
            format.json { render :json => response }
        end
    end

    def create
        if(params[:fname].strip == "" || params[:lname].strip == ""  || params[:lname_dot].strip == "" || params[:gpa].strip == "" ) then
            redirect_to :action => 'new', alert: 'Must fill in all of Contact Info and GPA'
            return 
        end
        value1 = params[:lname_dot] =~ /^[a-zA-Z]+\.[1-9]\d*$/
        value2 = params[:fname] =~ /^[a-zA-Z]+$/
        value3 = params[:fname] =~ /^[a-zA-Z]+$/
        value4 = params[:gpa] =~ /^[0-4]\.\d{1,2}$/
        if (value1 != 0) then
            redirect_to :action => 'new', alert: 'Last Name Dot field must fit this format: [last name].#'
            return
        elsif (value2 != 0 || value3 != 0 ) then
            redirect_to :action => 'new', alert: 'First and Last name must only include letters'
            return
        elsif (value3 != 0) then
            redirect_to :action => 'new', alert: 'GPA must fit in the range of 0.0 and 4.0'
            return
        end
        

        @grader = Grader.new(account_id: params[:account_id], name: params[:fname] + " " + params[:lname], last_name_dot: params[:lname_dot], gpa: params[:gpa]);
        if @grader.save
            if params.has_key?(:course) then
                params[:course].each do |key, value|
                    @className = ClassName.find_by(name: key)
                    @completedCourse = GraderCompletedCourse.create(grader_id: @grader.id, course_id: @className.id, grade: value[:grade])
                    if(value.has_key?(:time)) then
                        value[:time].each do |t|
                            @graderTimeAvailability = GraderTimeAvailability.create(grader_completed_course_id: @completedCourse.id, time: t)
                        end
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
            redirect_to :action => 'index', notice: 'Succcessfully submitted the application'
        else
            redirect_to :action => 'index', alert: 'Error trying to create a new application'
        end
    end

    def edit
        @alert = params[:alert]
        @courseValue = 0;
        @timeValue = 0;
        @grader = Grader.find(params[:id]);
        @completedCourses = GraderCompletedCourse.where(grader_id: params[:id])
        @previousCourses = GraderPreviousGradeCourse.where(grader_id: params[:id])
        @classNames = ClassName.all
        @teachings = Teaching.all
        @courses = Course.all
        @meetings = Meeting.all
        response = { :classNames => @classNames, :teachings => @teachings,
             :course=> @courses, :meetings => @meetings}
        respond_to do |format|
            format.html
            format.json { render :json => response }
        end
    end

    def update
        
        if(params[:fname].strip == "" || params[:lname].strip == ""  || params[:lname_dot].strip == "" || params[:gpa].strip == "" ) then
            redirect_to :action => 'edit' , id: params[:id] , alert: 'Must fill in all of Contact Info and GPA'
            return 
        end
        value1 = params[:lname_dot] =~ /^[a-zA-Z]+\.[1-9]\d*$/
        value2 = params[:fname] =~ /^[a-zA-Z]+$/
        value3 = params[:fname] =~ /^[a-zA-Z]+$/
        value4 = params[:gpa] =~ /^[0-4]\.\d{1,2}$/
        if (value1 != 0) then
            redirect_to :action => 'edit', id: params[:id], alert: 'Last Name Dot field must fit this format: [last name].#'
            return
        elsif (value2 != 0 || value3 != 0 ) then
            redirect_to :action => 'edit', id: params[:id], alert: 'First and Last name must only include letters'
            return
        elsif (value3 != 0) then
            redirect_to :action => 'edit ', id: params[:id], alert: 'GPA must fit in the range of 0.0 and 4.0'
            return
        end


        @grader = Grader.find(params[:id])
        @grader.name = params[:fname] + ' ' + params[:lname]
        @grader.last_name_dot = params[:lname_dot]
        @grader.gpa = params[:gpa]
        @completedCourses = GraderCompletedCourse.where(grader_id: params[:id])
        @previousCourses = GraderPreviousGradeCourse.where(grader_id: params[:id])
        @classNames = ClassName.all
        @teachings = Teaching.all
        @courses = Course.all
        @meetings = Meeting.all
        if @grader.save then
            if params.has_key?(:course) then
              @completedCourses.each do |q|
                 if !params[:ccEdit].include?(q) then
                    @time = GraderTimeAvailability.where(grader_completed_course_id: q.id)
                    @time.each do |t|
                        t.destroy
                    end
                    q.destroy
                 end
               end
               params[:course].each do |key, value|
                  @className = ClassName.find_by(name: key)
                  @completedCourse = GraderCompletedCourse.create(grader_id: @grader.id, course_id: @className.id, grade: value[:grade])
                  if(value.has_key?(:time)) then
                      value[:time].each do |t|
                          @graderTimeAvailability = GraderTimeAvailability.create(grader_completed_course_id: @completedCourse.id, time: t)
                      end
                  end
               end
           end

             #updates previous graded courses
            if params.has_key?(:gradedCourse) then
             @previousCourses.each do |p|
                 if !params[:gradedCourse].include?(p)
                   p.destroy
                 end
             end
             params[:gradedCourse].each do |c|
                 @className = ClassName.find_by(name: c)
                 @gradedPreviousCourse = GraderPreviousGradeCourse.create(grader_id: @grader.id, course_id: @className.id)
             end

             
           end
           redirect_to :action => 'index', notice: 'Sucessfully updated the application'
        else
            redirect_to :action => 'index', notice: 'Error updating the application'
        end

    end

    def delete
        @grader = Grader.find(params[:id])
        @previousCourses = GraderPreviousGradeCourse.where(grader_id: params[:id])
        puts @previousCourses
        @previousCourses.each do |p|
            p.destroy
        end
        @completedCourses = GraderCompletedCourse.where(grader_id: params[:id])

        @completedCourses.each do |c|
            @time = GraderTimeAvailability.where(grader_completed_course_id: c.id)
            @time.each do |t|
                t.destroy
            end
            c.destroy
        end
        puts @grader
        @grader.destroy
        redirect_to :action => 'index', notice: 'Successfully deleted the application'
    end

end
