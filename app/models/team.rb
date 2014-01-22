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

  attr_reader :user_tokens

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

end
