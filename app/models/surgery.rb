class Surgery < ActiveRecord::Base
  # Surgery connects the patient to a particular hospital. Although admission is a
  # better definition of the relationship, for the purpose of our app we can cut it
  # down to surgery
  # Because it is  join table, name of the surgery cannot be unique

  belongs_to :hospital
  belongs_to :patient
  validates :name,     presence: true,
                       uniqueness: { scope: [:date, :hospital_id, :patient_id, :category, :side, :region, :surgeon] }
  validates :date,     presence: true
  validates :hospital, presence: true
  validates :patient,  presence: true
  validates :category, presence: true,
                       inclusion: { in: ["Primary", "Revision"] }
  validates :side,     presence: true,
                       inclusion: { in: ["Right", "Left"] }
  validates :region,   presence: true,
                       inclusion: { in: ["Hip", "Knee", "Shoulder"] }
  validates :surgeon,  presence: true

end
