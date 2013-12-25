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
  resourcify
  belongs_to :user
  belongs_to :hospital
  validates :name, presence: true,
                   uniqueness: { scope: [:user_id, :hospital_id] }
  validates :hospital, presence: true
  validates :user, presence: true
  accepts_nested_attributes_for :hospital
  accepts_nested_attributes_for :user
end
