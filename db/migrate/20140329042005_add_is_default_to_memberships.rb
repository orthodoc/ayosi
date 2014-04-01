class AddIsDefaultToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :is_default, :boolean, default: false
  end
end
