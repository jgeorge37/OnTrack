# Created by Von Mbah on 2/26/20
# Goes through the course list and scrapes the data
# Modified: Jack Thompson - Fixed duplicates error
# Modified: Snigdha Tiwari - Added comments

class DataScraperController < ApplicationController
  def load
    # potentially for showing a loading spinner
  end

  def scrape
    Rails.application.load_seed
    redirect_to controller: 'menu', action: 'index'
  end

  def collect

    secondary_names = []
    # Gets the web page and makes it parseable
    agent = Mechanize.new
    page = agent.get("https://web.cse.ohio-state.edu/oportal/schedule_display")
    form = page.form_with(:dom_id => 'filter')
    form.field_with(:name => 'strm').options.each do |semester|
      semester.click
      semester_page = form.submit.parser
      course_list = semester_page.css('div.panel')
      course_list.each do |course|
        # Obtains the course title from the div.panel-heading element
       full_title = course.css('div.panel-heading').text.strip.to_s
       class_name = ''
       if !secondary_names.include?(full_title)
        class_name = ClassName.create(name: full_title)
        secondary_names.unshift(full_title)
       else
        class_name = ClassName.find_by(name: full_title)
       end
       # There are two classes of tables, group0 and group1. Iterate through both to obtain all the relevant info.
       rows_0 = course.css('table.table').first.css('tr.group0')
       rows_1 = course.css('table.table').first.css('tr.group1')
       # Loop for group0
       rows_0.each do |td|
           values = td.css('td')
           course = Teaching.where(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
             times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
             semester: semester.text, class_name_id: class_name.id
           ).first_or_create # do not create if already existing
       end
       # Loop for group1
       rows_1.each do |td|
         values = td.css('td')
         course = Teaching.where(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
           times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
           semester: semester.text, class_name_id: class_name.id
         ).first_or_create # do not create if already existing
       end
      end
    end

    names = ClassName.all
    classes = Teaching.all

    classes.each do |c|
      done = false

      course2 = Course.find_by(class_num: c.class_number, semester: c.semester)

      # in any case we need an instructor
      ins = Instructor.where(name: c.instructor).first_or_create

      # check if record is not in db
      if course2 == nil
        course2 = Course.create(
          class_num: c.class_number,
          semester: c.semester,
          name: names.find(c.class_name_id).name,
          session: c.session,
          component: c.component,
          attendance: false,
          num_graders: 0
        )
      else
        # check if only change is additional instructor for existing meeting
        course2.meetings.each do |meet|
          if meet.location == c.location && meet.time == c.times
            if not meet.instructors.include?(ins)
              meet.instructors.push(ins)
            end
            done = true
          end
        end
      end
      # now we either need to add the meeting or not change anything if meeting is already there
      if !done
        meet = course2.meetings.find_by(location: c.location, time: c.times)
        if meet == nil
          m = Meeting.create(location: c.location, time: c.times)
          m.instructors.push(ins)
          course2.meetings.push(m)
        end
      end
    end # end do each

    redirect_to controller: 'menu', action: 'index'
  end

end
