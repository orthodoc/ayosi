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
  # user_id used instead of user to pass rspec shoulda matcher for validating presence and
  # uniqueness of user scoped to hospital
  validates :user_id, presence: true,
                   uniqueness: { scope: :hospital_id }

  # Ensuring the is_default attribute takes a single default designation
  # http://stackoverflow.com/questions/4390983/setting-default-address-in-rails-user-model
  validates :is_default, uniqueness: { scope: [ :user_id, :hospital_id ],  unless: Proc.new { |designation| designation.is_default == 0 } }

  accepts_nested_attributes_for :hospital
  accepts_nested_attributes_for :user

  before_save :ensure_default_designation
  after_create :make_default_designation
  # When a user deletes his designation at a hospital (usually when she stops
  # working at that hospital), the following callback method ensures that associated
  # teams are also deleted
  # http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  before_destroy { |record| Team.where("user_id = ? AND hospital_id = ?", record.user_id, record.hospital_id).destroy_all }

  private

  # The first designation is made the default, in order to set the defautl hospital
  def make_default_designation
    unless self.user.designations.find_by(is_default: true)
      self.update_attributes(is_default: true)
    end
  end

  # The method ensures that there is only one default designation/hospital
  def ensure_default_designation
    if self.is_default == true
      d = self.user.designations.find_by(is_default: true)
      d.update_attributes(is_default: false) unless d.nil?
    end
  end

end
