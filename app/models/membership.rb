class Membership < ActiveRecord::Base
  include AASM
  belongs_to :user
  belongs_to :team

  validates :user, presence: true
  # The teams controller cannot create the membership as the team does not exist yet. Thus it cannot supply team_id.
  # So the validation exists only for the update action
  # http://stackoverflow.com/questions/14140994/failing-validations-in-join-model-when-using-has-many-through
  validates :team, presence: true, on: "update"
  validates_uniqueness_of :user_id, scope: :team_id
  # Ensuring the is_default attribute takes a single default designation
  # http://stackoverflow.com/questions/4390983/setting-default-address-in-rails-user-model
  validates :is_default, uniqueness: { scope: [ :user_id, :team_id ],  unless: Proc.new { |membership| membership.is_default == 0 } }

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :team

  before_save :ensure_default_membership
  after_create :make_default_membership

  aasm whiny_transactions: false do
    # All new user designations are inactive to start with
    state :inactive, initial: true
    # Awaiting activation by an admin
    state :pending
    # Banned from any further contributory activity
    state :banned
    # Can actively contribute to the database
    state :active
    # Request has been rejected by admin, but can apply again (in case of a mistake)
    state :rejected

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

  private

  # The first membership is made the default, in order to set the default team
  def make_default_membership
    unless self.user.memberships.find_by(is_default: true)
      self.update_attributes(is_default: true)
    end
  end

  # This method ensures that there is only on default membership/team
  def ensure_default_membership
    if self.is_default == true
      m = self.user.memberships.find_by(is_default: true)
      m.update_attributes(is_default: false) unless m.nil?
    end
  end

end
