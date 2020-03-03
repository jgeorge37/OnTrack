# Created by Von Mbah on 2/26/20
# Goes through the course list and scrapes the data
# Modified: Jack Thompson - Fixed duplicates error
# Modified: Snigdha Tiwari - Added comments

class DataScraperController < ApplicationController
  def scrape
    if ClassName.any?
      redirect_to :action => 'list'
      return
    end
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
    redirect_to :action => 'list'
  end

  def list
    @names = ClassName.all
    @course = Teaching.all
    render 'list'
  end
end

