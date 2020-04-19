class AdminPanelController < ApplicationController
  def index
    @filtered = filter_courses(params)
    @filter_opts = get_filter_opts(params)
  end

  def modify

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
        fc = fc.select {|c| c.description.session == par[:course][:session]}
      end
      if par[:course][:open].to_i == 1
        fc = fc.select {|c| c.description.num_graders - c.description.graders.length() > 0}
      end
    end
    return fc
  end

  def get_filter_opts(par)
    filters = {
      sem: ["All semesters"],
      name: ["All courses"],
      ses: ["All sessions"],
      open: [ ["Courses with and without open positions", 0], ["Only courses with open positions", 1] ]
    }

    filters[:sem] = Course.distinct.pluck(:semester)
    filters[:name] = Description.distinct.pluck(:name)
    filters[:name].map! {|n| n[0, n.index(' ', 7)]}
    filters[:ses] = Description.distinct.pluck(:session)

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
