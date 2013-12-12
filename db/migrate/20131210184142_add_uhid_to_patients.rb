class AddUhidToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :uhid, :string
  end
end
