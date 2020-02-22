require 'nokogiri'

require 'open-uri'

def web_scraper
  web_url =  "https://web.cse.ohio-state.edu/oportal/schedule_display"
  parsed_url = Nokogiri::HTML.parse(open(web_url))

  all_courses = Array.new
  class_array = Array.new

  # pareses for each panel which is each class and then loops through to get the name of each class
  course_list = parsed_url.css('div.panel')
  course_list.each do |course|
    course = {
        title: course_list.css('div.panel-heading').text

        # url: "https://courses.osu.edu/psp/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.OSR_CAT_SRCH.GBL" + course_list.css('a')[0].attributes["href"].value

    }
    all_courses << course
  end

  # parses for each table element which contains the elements in the loop
  class_table =parsed_url.css('table.table')

  class_table.each do |class_info|
    class_info = {
        classNumber_blue: class_table.css('tr.group0').text
        #component: class_table.css('td')[1].text,
        #location: class_table.css('td')[2].text,
        #times: class_table.css('td')[3].text,
        #course_session: class_table.css('td')[5].text
    }
    class_array << class_info
  end

  #print all_courses
  print class_array
  print ("Hello \n")
end

web_scraper