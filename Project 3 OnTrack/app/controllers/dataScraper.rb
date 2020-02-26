require 'nokogiri'
require 'mechanize'
require 'open-uri'

class Scraper

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
test.table_attributes
