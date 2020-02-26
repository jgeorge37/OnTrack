class DataScraperController < ApplicationController
  def scrape
    agent = Mechanize.new
    page = agent.get("https://web.cse.ohio-state.edu/oportal/schedule_display")
    form = page.form_with(:dom_id => 'filter');
    form.field_with(:name => 'strm').options.each do |semester|
      semester.click
      semester_page = form.submit.parser
      course_list = semester_page.css('div.panel')
      course_list.each do |course| 
       full_title = course.css('div.panel-heading').text.strip.to_s
       class_name = ClassName.new(name: full_title)
       class_name.save
       rows_0 = course.css('table.table').first.css('tr.group0')
       rows_1 = course.css('table.table').first.css('tr.group1')
       rows_0.each do |td| 
          values = td.css('td')
          course = Teaching.new(class_number: values[0].text.chomp, component: values[1].text.chomp, location: values[2].text.chomp,
            times: values[3].text.chomp, instructor: values[4].text.chomp, session: values[5].text.chomp, topic: values[6].text.chomp, 
            semester: semester.text, class_name_id: class_name.id
          )
          course.save
       end

       rows_1.each do |td| 
        values = td.css('td')
        course = Teaching.new(class_number: values[0].text.chomp, component: values[1].text.chomp, location: values[2].text.chomp,
          times: values[3].text.chomp, instructor: values[4].text.chomp, session: values[5].text.chomp, topic: values[6].text.chomp, 
          semester: semester.text, class_name_id: class_name.id
        )
        course.save
      end

      end
    end
  end

  def list
    @course = Teaching.all
  end
end

