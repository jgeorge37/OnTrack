module AdminPanelHelper

  def get_filter_opts(par)
    filters = {sem: ["All semesters"], name: ["All courses"], ses: ["All sessions"]}

    filters[:sem] = Course.distinct.pluck(:semester)
    filters[:name] = Description.distinct.pluck(:name)
    filters[:name].each do |n|
      n = n[0, n.index(' ', 7)]
    end
    filters[:ses] = Description.distinct.pluck(:session)

    filters[:sem].unshift("All semesters")
    filters[:name].unshift("All courses")
    filters[:ses].unshift("All sessions")

    # if parameters have been passed, the active filter should be the top option
    if par[:course]
      filters[:sem].unshift(par[:course][:semester])
      filters[:name].unshift(par[:course][:name])
      filters[:ses].unshift(par[:course][:session])
    end

    filters[:sem] = filters[:sem].uniq
    filters[:name] = filters[:name].uniq
    filters[:ses] = filters[:ses].uniq

    return filters
  end

  

end
