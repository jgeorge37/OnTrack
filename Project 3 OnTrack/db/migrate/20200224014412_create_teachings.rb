class CreateTeachings < ActiveRecord::Migration[6.0]
  def change
    create_table :teachings do |t|
      t.column :class_number, :integer
      t.column :component, :string
      t.column :location, :string
      t.column :times, :string
      t.column :instructor, :string
      t.column :session, :string
      t.column :topic, :string
      t.timestamps
    end
  end
end
