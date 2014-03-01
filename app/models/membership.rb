class Membership < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :team

  validates :user, presence: true
  # The teams controller cannot create the membership as the team does not exist yet. Thus it cannot supply team_id.
  # So the validation exists only for the update action
  # http://stackoverflow.com/questions/14140994/failing-validations-in-join-model-when-using-has-many-through
  validates :team, presence: true, on: "update"

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :team

  aasm whiny_transactions: false do
    state :inactive, initial: true   # All new user designations are inactive to start with
    state :pending                   # Awaiting activation by an admin
    state :banned                    # Banned from any further contributory activity
    state :active                    # Can actively contribute to the database
    state :rejected                  # Request has been rejected by admin, but can apply again (in case of a mistake)

    event :request do
      transitions from: [ :inactive, :rejected ], to: :pending
    end
    event :activate do
      transitions from: [ :inactive, :pending ], to: :active
    end
    event :deactivate do
      transitions from: :active, to: :inactive
    end
    event :resign do
      transitions from: :active, to: :inactive
    end
    event :reject do
      transitions from: :pending, to: :rejected
    end
    event :ban do
      transitions from: [ :active, :pending, :rejected], to: :banned
    end
  end
end
