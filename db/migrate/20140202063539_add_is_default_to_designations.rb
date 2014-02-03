class AddIsDefaultToDesignations < ActiveRecord::Migration
  def change
    add_column :designations, :is_default, :boolean, default: false
  end
end
