# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Clear out ClassName and Teaching (the scraping models)
ClassName.delete_all
Teaching.delete_all
# Clear out organization models
Meeting.delete_all
Course.delete_all
Instructor.delete_all

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
       course = Teaching.create(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
         times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
         semester: semester.text, class_name_id: class_name.id
       )
   end
   # Loop for group1
   rows_1.each do |td|
     values = td.css('td')
     course = Teaching.create(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
       times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
       semester: semester.text, class_name_id: class_name.id
     )
   end
  end
end


names = ClassName.all
classes = Teaching.all

classes.each do |c|
  done = false

  course2 = Course.find_by(class_num: c.class_number, semester: c.semester)

  # in any case we need an instructor
  ins = Instructor.find_by(name: c.instructor)
  if ins == nil
    ins = Instructor.create(name: c.instructor)
  end

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
  # if changes are needed, add the meeting
  if !done
    loc = c.location
    m = Meeting.create(location: loc, time: c.times)
    if not m.instructors.include?(ins)
      m.instructors.push(ins)
    end
    course2.meetings.push(m)
  end
end # end do each
