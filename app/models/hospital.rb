class Hospital < ActiveRecord::Base
  # Designation defines the join table for users and hospitals
  has_many :designations
  has_many :users, -> {distinct}, through: :designations

  # Surgery defines the join table for patients and hospitals
  has_many :surgeries
  has_many :patients, -> {distinct}, through: :surgeries

  has_many :teams

  # Many of the hospitals that are branches have the same name as the main branch,
  # so the name scoped to city would be unique. This doesn't solve for two branches
  # in the same city, but we are not solving all problems! This can overcome by
  # including the area in the name of the hospital.
  validates :name, presence: true,
                   uniqueness: { scope: :city }
  validates_presence_of :city

  accepts_nested_attributes_for :designations
  accepts_nested_attributes_for :surgeries

  # Class method to return all users associated with a hospital
  # This is not the same as hospital.users, which is an instance method and
  # derives the list of users through the designation association
  def self.users
    self.all.includes(:users).collect(&:users).flatten.uniq
  end

end
