class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Designation is the join table for users and hospitals
  has_many :designations
  has_many :hospitals, -> {distinct}, through: :designations

  # Client is the join table for users and patients
  has_many :clients
  has_many :patients, -> {distinct}, through: :clients

  # Membership is the join table for users(members) and teams
  has_many :memberships
  has_many :teams, -> {distinct}, through: :memberships

  # Validation for the rest are provided by devise. Validation that follows here are
  # for the extra fields that have been added to the user model eg: name
  validates_presence_of :name
  validates_presence_of :encrypted_password

  accepts_nested_attributes_for :designations
  accepts_nested_attributes_for :clients
  accepts_nested_attributes_for :memberships

end
