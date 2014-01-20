class AddUserIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :user_id, :integer
  end
end
