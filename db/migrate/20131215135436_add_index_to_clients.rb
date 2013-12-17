class AddIndexToClients < ActiveRecord::Migration
  def change
    add_index :clients, [:user_id, :patient_id], unique: true
  end
end
