class PatientForm < Reform::Form

  include Reform::Form::ActiveRecord

  properties [:name, :age, :birth_date, :gender, :uhid], on: :patient

  validates :name, :age, :gender, :uhid, presence: :true
  validates :age, numericality: true

  model :patient


end
