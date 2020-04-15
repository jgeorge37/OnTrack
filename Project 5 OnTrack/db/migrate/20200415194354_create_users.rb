class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :student_fname
      t.string :student_lname
      t.integer :student_lname_num

      t.string :teacher_fname
      t.string :teacher_lname
      t.integer :teacher_lname_num

      t.string :course

    end
  end
end
