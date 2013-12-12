class Patient < ActiveRecord::Base

  # Surgery is the join table for patients and hospitals
  has_many :surgeries
  has_many :hospitals, through: :surgeries

  # Client is the join table for patients and users
  has_many :clients
  has_many :users, through: :clients

  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :gender
  validates_presence_of :uhid

  accepts_nested_attributes_for :surgeries
  accepts_nested_attributes_for :clients


end
