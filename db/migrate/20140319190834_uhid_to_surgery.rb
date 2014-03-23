class UhidToSurgery < ActiveRecord::Migration
  def change
    remove_column :patients, :uhid, :string
    add_column :surgeries, :uhid, :string # It is often prefixed with strings
  end
end
