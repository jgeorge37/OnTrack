class MakeDiffUserTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :student_fname
    remove_column :users, :student_lname
    remove_column :users, :student_lname_num
    remove_column :users, :teacher_fname
    remove_column :users, :teacher_lname
    remove_column :users, :teacher_lname_num
    remove_column :users, :course
    remove_column :users, :course_section
    remove_column :users, :next_semester
    remove_column :users, :future_semester
    create_table :student_recommend do |t|
      t.string :student_fname
      t.string :student_lname
      t.integer :student_lname_num
      t.string :teacher_fname
      t.string :teacher_lname
      t.integer :teacher_lname_num
      t.string :course
      t.string :course_section
      t.boolean :future_semester
      t.boolean :next_semester
      t.timestamps
    end
  end
end
