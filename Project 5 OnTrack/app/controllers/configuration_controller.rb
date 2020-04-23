class ConfigurationController < ApplicationController
  def index
    @courses = []
    @properties = []
    @prop_hash = {}
    @with = "with"
    if params[:grouping]
      if params[:grouping][:inclusion] == "do not meet" then @with = "without" end

      check_sem = params[:semester].chomp.match(/^(((AU|SP|SU)\d{2}[,][ ])*)(AU|SP|SU)\d{2}$/)
      check_com = params[:component].chomp.match(/^(((LAB|LEC|REC)[,][ ])*)(LAB|LEC|REC)$/)
      check_num = params[:class_num].chomp.match(/^((\d{4,5}[,][ ])*)\d{4,5}$/)
      check_nam = params[:name].chomp.match(/^((\d{4}([H]?|[.]\d{2}[H]?)[,][ ])*)\d{4}([H]?|[.]\d{2}[H]?)$/)

      puts params
      if !check_sem && params[:semester].chomp != ""
        redirect_to action: 'index', alert: 'Semesters must be formatted as a 2-letter 2-digit code,
        separated by a comma and space if multiple.'
        return
      elsif !check_com && params[:component].chomp != ""
        redirect_to action: 'index', alert: 'Components must be formatted as a 3-letter code,
        separated by a comma and space if multiple.'
        return
      elsif !check_num && params[:class_num].chomp != ""
        redirect_to action: 'index', alert: 'Invalid class number format.'
        return
      elsif !check_nam && params[:name].chomp != ""
        redirect_to action: 'index', alert: 'Invalid number-in-name format.'
        return
      end
      organize_properties(params)
      find_courses(params)

    end
    update = 0
    if params[:config] # update the configuration for the found classes
      @courses.each {|c| Course.find(c.id).update(num_graders: params[:config][:num_g].to_i)}
      @courses.each {|c| Course.find(c.id).update(graders: Course.find(c.id).graders.take(params[:config][:num_g].to_i))}
      update = 1
    end
    if params[:attend] == "true"
      @courses.each {|c| Course.find(c.id).update(attendance: true)}
      update = 1
    elsif params[:attend] == "false"
      @courses.each {|c| Course.find(c.id).update(attendance: false) }
      update = 1
    end
    if update == 1
      puts @courses
      @courses.each {|c| puts Course.find(c.id).attendance}
      str = "Courses " + @with + " the properties " + @properties.join(", ") + " successfully updated."
      redirect_to action: 'index', notice: str
      return
    end

  end # end index

  private

  def organize_properties(params)
    # name is not included since the input name is only part of the recorded name
    sym_arr = ["semester", "component", "class_num", "name"]
    params.each do |k, v|
      if sym_arr.include?(k) && params[k]
        temp = v.split(", ")
        if !temp.empty?
          if k != "name" then @prop_hash[k] = temp end
          @properties.append(temp)
        end
      end
    end # end each
    if @prop_hash.key?("class_num")
      @prop_hash["class_num"].map!(&:to_i)
    end
  end # end organize_properties

  def find_courses(params)
    if params[:grouping][:inclusion] == "meet"
      @courses = Course.where(@prop_hash)
      if !params[:name].empty?
        @courses = @courses.select {|c| !(c.name.split(" ") & params[:name].split(", ")).empty?}
      end
    else
      @courses = Course.where.not(@prop_hash)
      if !params[:name].empty?
        @courses = @courses.select {|c| (c.name.split(" ") & params[:name].split(", ")).empty?}
      end
    end

  end # end find_courses
end
