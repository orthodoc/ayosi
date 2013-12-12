class Client < ActiveRecord::Base

  # Client is the join table for users and patients
  belongs_to :user
  belongs_to :patient
  validates_presence_of :user
  validates_presence_of :patient

end
