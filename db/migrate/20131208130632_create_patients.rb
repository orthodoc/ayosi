class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.date :birth_date
      t.integer :age
      t.string :gender
      t.references :hospital, index: true

      t.timestamps
    end
  end
end
