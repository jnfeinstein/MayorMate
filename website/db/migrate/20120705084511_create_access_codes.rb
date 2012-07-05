class CreateAccessCodes < ActiveRecord::Migration
  def change
    create_table :access_codes do |t|
      t.string :code
      t.references :user

      t.timestamps
    end
    add_index :access_codes, :user_id, :unique => true
  end
end
