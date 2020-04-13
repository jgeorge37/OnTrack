class AdminPanelController < ApplicationController
  def index
    @filtered = filter_courses(params)
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

end
