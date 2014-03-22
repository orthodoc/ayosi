class ChangeBirthDateOnPatientsToBirthday < ActiveRecord::Migration
  def change
    remove_column :patients, :birth_date, :date
    add_column :patients, :birthday, :date
  end
end
