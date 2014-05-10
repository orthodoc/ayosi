class PatientForm < Reform::Form

  include Reform::Form::ActiveRecord

  properties [:name, :age, :birthday, :gender], on: :patient

  # validations for patient attributes
  validates :name, :age, :gender, presence: :true, on: :patient
  validates :age, numericality: true

  model :patient

end
