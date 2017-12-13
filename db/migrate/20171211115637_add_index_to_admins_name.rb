class AddIndexToAdminsName < ActiveRecord::Migration[5.1]
  def change
    add_index :admins, :name, unique: true
  end
end
