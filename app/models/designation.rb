class Designation < ActiveRecord::Base
  # Designation is not the same as role
  # | Designation | Role   |
  # |-------------|--------|
  # | Surgeon     | Doctor |
  # | Registrar   | Doctor |
  # | Nurse       | Nurse  |
  # | Physio      | Physio |
  # ------------------------
  #
  belongs_to :user
  belongs_to :hospital
  validates :name, presence: true
  validates :hospital, presence: true
  validates :user, presence: true
end
