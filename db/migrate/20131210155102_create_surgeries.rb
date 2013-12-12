class CreateSurgeries < ActiveRecord::Migration
  def change
    create_table :surgeries do |t|
      t.string :name
      t.date :date
      t.references :hospital, index: true
      t.references :patient, index: true

      t.timestamps
    end
  end
end
