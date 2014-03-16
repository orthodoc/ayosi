class HospitalDecorator < Draper::Decorator
  delegate_all
  decorates_association :users
  decorates_association :designations

end
