class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Designation is the join table for users and hospitals
  has_many :designations
  has_many :hospitals, through: :designations

  # Client is the join table for users and patients
  has_many :clients
  has_many :patients, through: :clients

  validates_presence_of :name
  validates_presence_of :encrypted_password

  accepts_nested_attributes_for :designations
  accepts_nested_attributes_for :clients

end
