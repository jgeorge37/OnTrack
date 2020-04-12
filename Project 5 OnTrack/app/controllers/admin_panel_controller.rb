class AdminPanelController < ApplicationController
  def index
    set_up_vars
  end

  def modify
    set_up_vars
  end

  def set_up_vars
    names = ClassName.all
    courses = Teaching.all
    # Make map for class number, semester -> all other info
    @map = Hash.new
    courses.each do |c|
      done = false
      # get class number and semester for key
      key = [c.class_number, c.semester]
      # if key is not already in map
      if !@map.key?(key)
        # some classes have different meeting schedules throughout the week
        # each meeting has location, time, instructor(s)
        @map[key] = {name: names.find(c.class_name_id).name, session: c.session, component: c.component, attd: true, num_g: 0, grader_ids: [], meetings: []}
      # check if only change is additional instructor for an existing meeting
      else
        @map[key][:meetings].each do |r|  # r is each hash in the meeting array of hashes
          # if location and time are the same, only add instructor
          if r[:location] == c.location && r[:times] == c.times
            r[:instructors].push(c.instructor)
            done = true  # no more changes needed
          end
        end
      end
      # if changes are needed, add the meeting
      if !done
        # make meeting as a hash
        loc = c.location
        if loc == " " then loc = "Location N/A" end
        meeting = {location: loc, times: c.times, instructors: [c.instructor] }
        # add meeting to list of meetings
        @map[key][:meetings].push(meeting)
      end
    end # end do-each
  end  # end set_up_vars


end
