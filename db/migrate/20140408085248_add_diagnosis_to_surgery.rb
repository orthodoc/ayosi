class AddDiagnosisToSurgery < ActiveRecord::Migration
  def change
    add_column :surgeries, :diagnosis, :string
  end
end
