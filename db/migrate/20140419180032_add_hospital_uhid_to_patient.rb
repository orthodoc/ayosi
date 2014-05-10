class AddHospitalUhidToPatient < ActiveRecord::Migration
  def change
    # Remove uhid from surgery and add unique index
    remove_column :surgeries, :uhid, :string
    add_index :surgeries, [:procedure, :patient_id, :hospital_id, :date, :category, :side, :region, :surgeon], name: "surgery_unique_index", unique: true


    # Add uhid and hospital_id back to patient model and create a unique index
    add_column :patients, :uhid, :string
    add_column :patients, :hospital_id, :integer
    add_index :patients, [:name, :age, :gender, :hospital_id, :uhid], name: "patient_unique_index", unique: true
  end
end
