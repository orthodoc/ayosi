class Patient < ActiveRecord::Base

  # Surgery is the join table for patients and hospitals
  has_many :surgeries
  has_many :hospitals, -> {distinct}, through: :surgeries

  # Client is the join table for patients and users
  has_many :clients
  has_many :users, -> {distinct}, through: :clients


  accepts_nested_attributes_for :surgeries
  accepts_nested_attributes_for :clients

  # Birthday gem to get the age and other methods
  acts_as_birthday :birthday


end
