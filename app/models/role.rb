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

  def self.admins
    admin_roles = %w[admin group_admin]
    roles = Array.new
    admin_roles.each do |ar|
      role = Role.find_by!(name: ar)
      roles << role
    end
    return roles
  end

  def self.group_admin
    role = Role.find_by!(name: "group_admin")
    return role
  end
  
end
