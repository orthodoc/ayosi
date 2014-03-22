class PatientForm < Reform::Form

  include Reform::Form::ActiveRecord

  properties [:name, :age, :birthday, :gender], on: :patient

  validates :name, :age, :gender, presence: :true
  validates :age, numericality: true

  model :patient


end
