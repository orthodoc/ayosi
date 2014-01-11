class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
  
  def self.hospital_staff
    hospital_roles  = %w[doctor nurse physio office_manager data_operator media_manager secretary]
    roles = Array.new
    hospital_roles.each do |hr|
      role = Role.find_by(name: hr)
      roles << role
    end
    return roles
  end

  def self.admin
    role = Role.find_by!(name: "admin")
    return role
  end
  
end
