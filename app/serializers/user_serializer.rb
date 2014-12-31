class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :category
end
