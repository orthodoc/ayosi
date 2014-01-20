class Team < ActiveRecord::Base
  belongs_to :hospital
  has_many :memberships
  has_many :members, -> {distinct}, through: :memberships,
                                    source: :user
  belongs_to :user
  validates :name, presence: true,
                   uniqueness: true
  validates_presence_of :hospital
  validates_presence_of :user
  accepts_nested_attributes_for :members

end
