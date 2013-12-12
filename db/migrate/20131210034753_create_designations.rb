class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.string :name
      t.references :user, index: true
      t.references :hospital, index: true

      t.timestamps
    end
  end
end
