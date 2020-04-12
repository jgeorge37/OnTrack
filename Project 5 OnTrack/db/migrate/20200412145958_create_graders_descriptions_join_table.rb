class CreateGradersDescriptionsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :graders, :descriptions do |t|
      t.index :grader_id
      t.index :description_id
    end
  end
end
