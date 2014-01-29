class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :user, presence: true
  # The teams controller cannot create the membership as the team does not exist yet. Thus it cannot supply team_id.
  # So the validation exists only for the update action
  # http://stackoverflow.com/questions/14140994/failing-validations-in-join-model-when-using-has-many-through
  validates :team, presence: true, on: "update"
end
