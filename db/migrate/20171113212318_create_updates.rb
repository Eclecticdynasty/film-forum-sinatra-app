class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
