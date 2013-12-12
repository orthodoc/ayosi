class RemoveHospitalIdFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :hospital_id, :integer
  end
end
