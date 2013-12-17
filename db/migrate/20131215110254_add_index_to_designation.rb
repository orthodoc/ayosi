class AddIndexToDesignation < ActiveRecord::Migration
  def change
    add_index :designations, [:name, :user_id, :hospital_id], unique: true
  end
end
