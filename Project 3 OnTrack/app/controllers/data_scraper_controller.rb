class DataScraperController < ApplicationController
  def scrape
    if ClassName.any?
      redirect_to :action => 'list'
      return
    end
    current_names = ClassName.all
    secondary_names = []
    current_classes = Teaching.all
    agent = Mechanize.new
    page = agent.get("https://web.cse.ohio-state.edu/oportal/schedule_display")
    form = page.form_with(:dom_id => 'filter');
    form.field_with(:name => 'strm').options.each do |semester|
      semester.click
      semester_page = form.submit.parser
      course_list = semester_page.css('div.panel')
      course_list.each do |course| 
       full_title = course.css('div.panel-heading').text.strip.to_s
       unless current_names.include?(full_title) || secondary_names.include?(full_title)
        class_name = ClassName.create(name: full_title)
        secondary_names.unshift(full_title)
        rows_0 = course.css('table.table').first.css('tr.group0')
        rows_1 = course.css('table.table').first.css('tr.group1')
        rows_0.each do |td|
            values = td.css('td')
            course = Teaching.create(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
              times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
              semester: semester.text, class_name_id: class_name.id
            )
        end

        rows_1.each do |td|
          values = td.css('td')
          course = Teaching.create(class_number: values[0].text.to_i, component: values[1].text, location: values[2].text,
            times: values[3].text, instructor: values[4].text, session: values[5].text, topic: values[6].text,
            semester: semester.text, class_name_id: class_name.id
          )
        end
      end

      end
    end
    redirect_to :action => 'list'
    return
  end

  def list
    @names = ClassName.all
    @course = Teaching.all
    render 'list'
  end
end

