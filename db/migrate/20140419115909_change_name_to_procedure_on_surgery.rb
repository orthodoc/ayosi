class ChangeNameToProcedureOnSurgery < ActiveRecord::Migration
  def change
    remove_column :surgeries, :name, :string
    add_column :surgeries, :procedure, :string
  end
end
