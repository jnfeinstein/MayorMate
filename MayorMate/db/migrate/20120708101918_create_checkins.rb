class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :count
      t.string :job_id
      t.string :time
      t.string :venue_id
      t.references :user

      t.timestamps
    end
    add_index :checkins, :user_id
  end
end
