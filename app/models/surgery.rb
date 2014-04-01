class Surgery < ActiveRecord::Base
  # Surgery connects the patient to a particular hospital. Although admission is a
  # better definition of the relationship, for the purpose of our app we can cut it
  # down to surgery
  # Because it is  join table, name of the surgery cannot be unique

  belongs_to :hospital
  belongs_to :patient

end
