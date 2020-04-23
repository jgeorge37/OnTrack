class ConfigurationController < ApplicationController
  def index
    @view = false
    @change = false
    if(params[:grouping])
      if(params[:grouping][:action] == "view") then @view = true end
      if(params[:grouping][:action] == "create or change") then @change = false end
    end

  end
end
