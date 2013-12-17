class AddIndexToSurgery < ActiveRecord::Migration
  def change
    add_index :surgeries, [:name, :date, :hospital_id, :patient_id, :category, :side, :region, :surgeon], unique: true, name: "unique_surgery_attributes_index"
  end
end
