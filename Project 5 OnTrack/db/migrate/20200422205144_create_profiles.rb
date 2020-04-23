class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :f_name
      t.string :l_name

      t.timestamps
    end
  end
end
