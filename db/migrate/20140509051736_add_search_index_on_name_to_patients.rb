class AddSearchIndexOnNameToPatients < ActiveRecord::Migration
  def change
    execute "create index patients_name on patients using gin(to_tsvector('english', name))"
  end
end
