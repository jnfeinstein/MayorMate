class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :count, :default => 0
      t.string :job_id
      t.string :time
      t.string :time_zone
      t.string :venue_id
      t.references :user

      t.timestamps
    end
    add_index :checkins, :user_id
  end
end
