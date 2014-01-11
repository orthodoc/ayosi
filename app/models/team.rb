class Team < ActiveRecord::Base
  belongs_to :hospital
  has_many :memberships
  has_many :members, -> {distinct}, through: :memberships,
                                    source: :user
  has_one :owner, through: :members,
                  source: :user
  validates :name, presence: true,
                   uniqueness: true
  validates_presence_of :hospital
  accepts_nested_attributes_for :members
  accepts_nested_attributes_for :owner
end
