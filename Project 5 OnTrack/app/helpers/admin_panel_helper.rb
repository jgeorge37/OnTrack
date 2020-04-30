module AdminPanelHelper
  def get_recs(grader)
    rec_arr = []
    # array with last name and dot number
    ndn = grader.last_name_dot.split(".")
    # get all recommendations associated with student
    recs = StudentRecommend.where(student_lname: ndn[0].capitalize, student_lname_num: ndn[1]).or(StudentRecommend.where(student_lname: ndn[0], student_lname_num: ndn[1]))
    recs.each do |r|
      str = "Student has been "
      if r.course_specification.chomp == 'G'
        str.concat("generally recommended to grade #{r.course}")
      elsif r.course_specification.chomp == 'S'
        str.concat("specifically requested to grade #{r.course}, class number #{r.course_section},")
      end
      str.concat(" by #{r.teacher_fname} #{r.teacher_lname}.")
      rec_arr.push(str)
    end
    return rec_arr
  end

  def get_evals(grader)
    eval_arr = ["Evaluation scores out of 5:"]
    # get list of all evals of this student
    evals = Evaluation.where(grader_lname_dotnum: grader.last_name_dot)
    evals.each do |e|
      str = "#{e.course} -- Grading quality: #{e.quality} | Punctuality: #{e.punctuality}"
      str.concat(" | Communication: #{e.com_skills} | Knowledge: #{e.course_knowledge}")
      eval_arr.push(str)
    end
    return eval_arr
  end

  def enable_add(params)
    c = Course.find(params[:id])
    if c.graders.length().to_i == c.num_graders.to_i then return false end
    return true
  end

end
