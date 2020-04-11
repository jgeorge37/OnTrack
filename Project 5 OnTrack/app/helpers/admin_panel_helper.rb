module AdminPanelHelper

  def get_filter_opts(map)
    filters = {sem: ["All semesters"], course: ["All courses"], ses: ["All sessions"]}
    map.each do |k, v|
      filters[:sem].push(k[1])
      # cut off rest of class name beyond "CSE ####(H)"
      filters[:course].push(v[:name][0, v[:name].index(' ', 4)])
      filters[:ses].push(v[:session])
    end
    filters[:sem] = filters[:sem].uniq()
    filters[:course] = filters[:course].uniq()
    filters[:ses] = filters[:ses].uniq()

    return filters
  end

end
