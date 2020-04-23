class ConfigurationController < ApplicationController
  def index
    @view = false
    @change = false
    @courses = []
    @properties = {}
    @with = "with"
    if params[:grouping]
      if params[:grouping][:action] == "view" then @view = true end
      if params[:grouping][:action] == "create or change" then @change = true end
      if params[:grouping][:inclusion] == "do not meet" then @with = "without" end

      check_sem = params[:semester].chomp.match(/^(((AU|SP|SU)\d{2}[,][ ])*)(AU|SP|SU)\d{2}$/)
      check_com = params[:component].chomp.match(/^(((LAB|LEC|REC)[,][ ])*)(LAB|LEC|REC)$/)
      check_num = params[:c_number].chomp.match(/^    ((\d{4,5}[,][ ])*)\d{4,5}   $/)
      check_nam = params[:c_name].chomp.match(/^((\d{4}([H]?|[.]\d{2}[H]?)[,][ ])*)\d{4}([H]?|[.]\d{2}[H]?)$/)

      puts params
      if !check_sem && params[:semester].chomp != ""
        redirect_to action: 'index', alert: 'Semesters must be formatted as a 2-letter 2-digit code,
        separated by a comma and space if multiple.'
        return
      elsif !check_com && params[:component].chomp != ""
        redirect_to action: 'index', alert: 'Components must be formatted as a 3-letter code,
        separated by a comma and space if multiple.'
        return
      elsif !check_num && params[:c_number].chomp != ""
        redirect_to action: 'index', alert: 'Invalid class number format.'
        return
      elsif !check_nam && params[:c_name].chomp != ""
        redirect_to action: 'index', alert: 'Invalid number-in-name format.'
        return
      end
      organize_properties(params)
      find_courses(params)
    end

  end # end index

  private

  def organize_properties(params)


  end # end organize_properties

  def find_courses(params)
    if params[:grouping][:inclusion] == "meet"
      @courses = Course.where(@properties)
    end



  end # end find_courses
end
