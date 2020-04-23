class AdminPanelController < ApplicationController
  before_action :authenticate_admin!

  def index
    @filtered = filter_courses(params)
    @filter_opts = get_filter_opts(params)
  end

  def modify
    c = Course.find(params[:id])
    if params[:gr]
      if params[:rm] && c.graders.find_by(id: params[:gr]) != nil
        c.graders.delete(Grader.find(params[:gr]))
      elsif c.graders.find_by(id: params[:gr]) == nil
        c.graders.push(Grader.find(params[:gr]))

      end
    end
    @assigned = c.graders
    @filtered = filter_graders(params)
  end



  private

  def filter_courses(par)
    fc = Course.all

    if par[:course]
      if par[:course][:semester] != "All semesters"
        fc = fc.where(semester: par[:course][:semester])
      end
      if par[:course][:session] != "All sessions"
        fc = fc.where(session: par[:course][:session])
      end
      if par[:course][:name] != "All courses"
        fc = fc.select {|c| c.name[0, c.name.index(' ', 7)] == par[:course][:name]}
      end
      if par[:course][:open].to_i == 1
        fc = fc.select {|c| c.num_graders - c.graders.length() > 0}
      end
    end
    return fc
  end

  def filter_graders(params)
    filtered = []
    c = Course.find(params[:id])
    # get the className id
    cn_id = ClassName.find_by(name: c.name)

    meeting_times = []
    # get the list of times that this class meets
    c.meetings.each {|m| meeting_times.push(m.time)}

    graders_list = Grader.all
    graders_list.each do |g|
      if c.graders.find_by(id: g.id) == nil
        # check if course is complete
        completed = GraderCompletedCourse.find_by(grader_id: g.id, course_id: cn_id)
        # check for availability
        if completed != nil
          if !c.attendance
            filtered.push(g) # if attendance is not required, they are eligible
          else
            times = []
            GraderTimeAvailability.where(grader_completed_course_id: completed.id).each do |t|
              times.push(t.time)
            end
            if (meeting_times - times).empty?
              filtered.push(g) # grader is eligible if they are available
            end
          end
        end
      end
    end
    return filtered
  end

  def get_filter_opts(par)
    filters = {
      sem: ["All semesters"],
      name: ["All courses"],
      ses: ["All sessions"],
      open: [ ["Courses with and without open positions", 0], ["Only courses with open positions", 1] ]
    }

    filters[:sem] = Course.distinct.pluck(:semester)
    filters[:name] = Course.distinct.pluck(:name)
    filters[:name].map! {|n| n[0, n.index(' ', 7)]}
    filters[:ses] = Course.distinct.pluck(:session)

    filters[:sem].unshift("All semesters")
    filters[:name].unshift("All courses")
    filters[:ses].unshift("All sessions")

    # if parameters have been passed, the active filter should be the top option
    if par[:course]
      filters[:sem].unshift(par[:course][:semester])
      filters[:name].unshift(par[:course][:name])
      filters[:ses].unshift(par[:course][:session])
      if par[:course][:open].to_i == 1
        filters[:open].reverse!
      end
    end

    filters[:sem] = filters[:sem].uniq
    filters[:name] = filters[:name].uniq
    filters[:ses] = filters[:ses].uniq

    return filters
  end

end
