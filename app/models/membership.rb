class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :user, presence: true
  validates :team, presence: true
end
