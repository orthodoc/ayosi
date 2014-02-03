class Designation < ActiveRecord::Base
  # Designation is not the same as role
  # | Designation | Role   |
  # |-------------|--------|
  # | Surgeon     | Doctor |
  # | Registrar   | Doctor |
  # | Nurse       | Nurse  |
  # | Physio      | Physio |
  # | Patient     | Patient|
  # ------------------------
  #
  include AASM
  resourcify
  belongs_to :user
  belongs_to :hospital
  validates :name, presence: true
  validates :hospital, presence: true
  validates :user_id, presence: true,
                   uniqueness: { scope: :hospital_id }

  # Ensuring the is_default attribute takes a single default designation
  # http://stackoverflow.com/questions/4390983/setting-default-address-in-rails-user-model
  validates :is_default, uniqueness: { scope: :user_id,  unless: Proc.new { |designation| designation.is_default == 0 } }

  # user_id used instead of user to pass rspec shoulda matcher for validating presence and
  # uniqueness of user scoped to hospital
  accepts_nested_attributes_for :hospital
  accepts_nested_attributes_for :user

  after_create :make_default_designation


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

  private

  # The first designation is made the default, in order to set the defautl hospital
  def make_default_designation
    unless self.user.designations.find_by(is_default: true)
      self.update_attributes(is_default: true)
    end
  end

end
