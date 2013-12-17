class Client < ActiveRecord::Base

  # Client is the join table for users and patients
  belongs_to :user
  belongs_to :patient
  validates :user_id, presence: true,
                      uniqueness: { scope: [:patient_id] }
  validates :patient, presence: true

end
