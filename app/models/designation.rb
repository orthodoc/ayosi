class Designation < ActiveRecord::Base
  # Designation is not the same as role
  # | Designation | Role   |
  # |-------------|--------|
  # | Surgeon     | Doctor |
  # | Registrar   | Doctor |
  # | Nurse       | Nurse  |
  # | Physio      | Physio |
  # ------------------------
  #
  include AASM
  resourcify
  belongs_to :user
  belongs_to :hospital
  validates :name, presence: true,
                   uniqueness: { scope: [:user_id, :hospital_id] }
  validates :hospital, presence: true
  validates :user, presence: true
  accepts_nested_attributes_for :hospital
  accepts_nested_attributes_for :user

  aasm whiny_transactions: false do
    state :inactive, initial: true   # All new user designations are inactive to start with
    state :pending                   # Awaiting activation by an admin
    state :banned                    # Banned from any further contributory activity
    state :active                    # Can actively contribute to the database
    state :rejected                  # Request has been rejected by admin, but can apply again (in case of a mistake)
    state :default                   # The first designation is automatically in default state. Necessary for getting the associated hospital.

    event :request do
      transitions from: [ :inactive, :rejected ], to: :pending
    end
    event :activate do
      transitions from: [ :inactive, :pending, :default ], to: :active
    end
    event :make_default do
      transitions from: :active, to: :default
    end
    event :deactivate do
      transitions from: [ :active, :default ], to: :inactive
    end
    event :resign do
      transitions from: [ :active, :default ], to: :inactive
    end
    event :reject do
      transitions from: :pending, to: :rejected
    end
    event :ban do
      transitions from: [ :default, :active, :pending, :rejected], to: :banned
    end
  end
end
