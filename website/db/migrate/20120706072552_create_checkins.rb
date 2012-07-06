class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :venue
      t.string :time
      t.boolean :enabled
      t.references :user

      t.timestamps
    end
    add_index :checkins, :user_id
  end
end
