class EvaluationsController < ApplicationController
  def index
    @grader = Grader.all
    @rate = Array(1..5)
  end
end
