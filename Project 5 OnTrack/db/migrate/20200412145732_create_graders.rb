class CreateGraders < ActiveRecord::Migration[6.0]
  def change
    create_table :graders do |t|
      t.string :name

      t.timestamps
    end
  end
end
