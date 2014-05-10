class ChangeHospitalOnPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :hospital_id, :integer
    change_table :patients do |t|
      t.references :hospital, index: true
    end
    add_index :patients, [:name, :age, :gender, :hospital_id, :uhid], name: "patient_unique_index", unique: true
  end
end
