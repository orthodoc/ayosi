class Team < ActiveRecord::Base
  belongs_to :hospital
  has_many :memberships, dependent: :destroy
  has_many :members, -> {distinct}, through: :memberships,
                                    source: :user
  # To define ownership of the team
  belongs_to :user
  validates :name, presence: true,
                   uniqueness: { scope: :hospital_id }
  validates_presence_of :hospital
  validates_presence_of :user
  accepts_nested_attributes_for :members

  after_save :assign_members

  def owner
    self.user
  end

  # member_list is a virtual attribute. The following method sets the collection of
  # member_ids. Rails prefers an array for the collection while select2 sets comma
  # separated values.The setter method below converts the comma separated values to an array
  # for select2 to work with rails
  def member_list=(ids)
    @member_list = []
    ids.split(",").each do |id|
      @member_list << id.to_i
    end
    @member_list = @member_list.reject{|id| id == /\D/}
  end

  # member_list is a virtual attribute. Getter method below.
  def member_list
    @member_list
    #@member_list = self.member_ids
  end

  private
  # Since member_list is a virtual attribute, the assign_members method assigns
  # the members to the team. Ordinarily this is done magically when the collection
  # is member_ids on a members association.
  def assign_members
    unless @member_list.nil?
      @member_list = @member_list.reject{|id| id == 0 }
    end
    unless @member_list.nil?
      @member_list.each do |member_id|
        @user = User.find(member_id)
        self.members << @user
      end
    end
  end

end
