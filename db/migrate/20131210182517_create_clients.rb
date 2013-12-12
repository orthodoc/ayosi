class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :user, index: true
      t.references :patient, index: true

      t.timestamps
    end
  end
end
