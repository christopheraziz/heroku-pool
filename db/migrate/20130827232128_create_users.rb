class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "first_name", :limit => 50
      t.string "last_name", :limit => 50
      t.string "email", :limit => 100
      t.string "password", :limit => 50
      t.string "image", :limit => 100, :null => true
      t.timestamps
    end
  end
end
