class ChangeIndexToDesignation < ActiveRecord::Migration
  def change
    remove_index :designations, name: "index_designations_on_name_and_user_id_and_hospital_id"
    add_index :designations, [:user_id, :hospital_id], unique: true
  end
end
