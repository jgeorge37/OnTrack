class CreateClassNames < ActiveRecord::Migration[6.0]
  def change
    create_table :class_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
