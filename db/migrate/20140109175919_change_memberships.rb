class ChangeMemberships < ActiveRecord::Migration
  def change
    remove_reference :memberships, :member
    add_reference :memberships, :user, index: true
  end
end
