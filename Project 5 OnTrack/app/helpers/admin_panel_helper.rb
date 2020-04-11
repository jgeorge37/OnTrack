module AdminPanelHelper

  def get_filter_opts(map, par)
    filters = {sem: ["All semesters"], name: ["All courses"], ses: ["All sessions"]}
    # if parameters have been passed, the active filter should be the top option
    if par[:course]
      filters[:sem].unshift(par[:course][:semester])
      filters[:name].unshift(par[:course][:name])
      filters[:ses].unshift(par[:course][:session])
    end
    map.each do |k, v|
      filters[:sem].push(k[1])
      # cut off rest of class name beyond "CSE ####(H)"
      filters[:name].push(v[:name][0, v[:name].index(' ', 4)])
      filters[:ses].push(v[:session])
    end
    filters[:sem] = filters[:sem].uniq()
    filters[:name] = filters[:name].uniq()
    filters[:ses] = filters[:ses].uniq()

    return filters
  end

  def filter_courses(map, par)
    # clone map for filtered map
    fm = map.clone()
    if par[:course]
      if par[:course][:semester] != "All semesters"
        fm = fm.select {|k, v| k[1] == par[:course][:semester]}
      end
      if par[:course][:name] != "All courses"
        fm = fm.select {|k, v| v[:name][0, v[:name].index(' ', 4)] == par[:course][:name]}
      end
      if par[:course][:session] != "All sessions"
        fm = fm.select {|k, v| v[:session] == par[:course][:session]}
      end
    end
    return fm
  end

end
