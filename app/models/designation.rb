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

  private

  # The first designation is made the default, in order to set the defautl hospital
  def make_default_designation
    unless self.user.designations.find_by(is_default: true)
      self.update_attributes(is_default: true)
    end
  end

end
