require 'nokogiri'
require 'mechanize'
require 'open-uri'
class Scraper
  
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

  def  list 

  end 

  def initialize
    @agent = Mechanize.new
    @page = @agent.get("https://web.cse.ohio-state.edu/oportal/schedule_display")

  end

  def course_names
    all_courses = Array.new
    parsed_url = @page.parser
    course_list = parsed_url.css('div.panel')
    course_list.each do |course|
      #This get the course name at the top of every head box
      full_title = course.css('div.panel-heading').text.strip.to_s
      course = {

          title: full_title

          #credit_hours: full_title[full_title.rindex("U"),full_title.length]
          # url: "https://courses.osu.edu/psp/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.OSR_CAT_SRCH.GBL" + course_list.css('a')[0].attributes["href"].value

      }
      all_courses << course


    end
    # for testing purposes
    # print all_courses
  end

  def table_attributes
    class_array = Array.new
    parsed_url = @page.parser
    class_table = parsed_url.css('table.table')
    #print class_table
    class_table.each do |class_info|
      class_info = {
          #This gets the classNumber for the blue text boxes in group 0
          classNumber_blue: class_info.css('tr.group0 > td:first-child').text[0,class_info.css('tr.group0 > td:first-child').text.length/2],
          component_blue: class_info.css('tr.group0 > td:nth-child(2)').text[0,class_info.css('tr.group0 > td:nth-child(2)').text.length/2],

          
          # location: class_table.css('tr.group0 > td:nth-child(3)').text
          #times: class_table.css('td')[3].text,
          #course_session: class_table.css('td')[5].text
      }
      class_array << class_info
    end
    #when you run this, it will display the 0th element of the array
    print class_array[0]
  end


end
#testing purposes
test = Scraper.new
test.scrape
# test.table_attributes
