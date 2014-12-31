class PatientSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender, :birthday
end
