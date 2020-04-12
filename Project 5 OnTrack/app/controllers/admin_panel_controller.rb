class AdminPanelController < ApplicationController
  def index
    @filtered = filter_courses(params)
  end

  def modify
    
  end

  def load
    if !Course.any?
      names = ClassName.all
      classes = Teaching.all

      classes.each do |c|
        done = false

        course = Course.find_by(class_num: c.class_number, semester: c.semester)

        # in any case we need an instructor
        ins = Instructor.find_by(name: c.instructor)
        if ins == nil
          ins = Instructor.create(name: c.instructor)
        end

        # check if record is not in db
        if course == nil
          course = Course.create(class_num: c.class_number, semester: c.semester)

          # add description
          course.description = Description.create(
            name: names.find(c.class_name_id).name,
            session: c.session,
            component: c.component,
            attendance: false,
            num_graders: 0)
        else
          # check if only change is additional instructor for existing meeting
          course.description.meetings.each do |meet|
            if meet.location == c.location && meet.time == c.times
              meet.instructors.push(ins)
              done = true
            end
          end
        end
        # if changes are needed, add the meeting
        if !done
          loc = c.location
          if loc == " " then loc = "Location N/A" end
          m = Meeting.create(location: loc, time: c.times)
          m.instructors.push(ins)
          course.description.meetings.push(m)
        end
      end # end do each
    end # end if

    redirect_to action: "index"

  end

  private

  def filter_courses(par)
    fc = Course.all

    if par[:course]
      if par[:course][:semester] != "All semesters"
        fc = fc.select {|c| c.semester == par[:course][:semester]}
      end
      if par[:course][:name] != "All courses"
        fc = fc.select {|c| c.description.name[0, c.description.name.index(' ', 7)] == par[:course][:name]}
      end
      if par[:course][:session] != "All sessions"
        fc = fc.select {|c| c.description.name == par[:course][:session]}
      end
    end
    return fc
  end

end
