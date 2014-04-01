class DataEntryForm < Reform::Form

  include Reform::Form::ActiveRecord
  include Composition

  properties [:name, :age, :birthday, :gender], on: :patient
  properties [:name, :date, :hospital_id, :patient_id, :category, :side, :region, :surgeon, :uhid], on: :surgery

  # validations for patient attributes
  validates :name, :age, :gender, presence: :true, on: :patient
  validates :age, numericality: true

  # validations for surgery attributes
  validates :name,     presence: true,
                       uniqueness: { scope: [:date, :hospital_id, :patient_id, :category, :side, :region, :surgeon] }, on: :surgery
  validates :date,     presence: true
  validates :hospital_id, presence: true
  validates :uhid,     presence: true
  validates :patient_id,  presence: true
  validates :category, presence: true,
                       inclusion: { in: ["Primary", "Revision"] }
  validates :side,     presence: true,
                       inclusion: { in: ["Right", "Left"] }
  validates :region,   presence: true,
                       inclusion: { in: ["Hip", "Knee", "Shoulder"] }
  validates :surgeon,  presence: true

  model :patient

end
