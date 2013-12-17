class ChangeSideToStringOnSurgery < ActiveRecord::Migration
  def change
    change_column :surgeries, :side, :string
  end
end
