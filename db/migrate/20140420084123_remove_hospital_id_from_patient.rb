class RemoveHospitalIdFromPatient < ActiveRecord::Migration
  def change
    remove_column :patients, :hospital_id, :integer
    remove_column :patients, :uhid, :string
    add_index :patients, [:name, :age, :gender], name: "patient_unique_index", unique: true
  end
end
