class ChangeCategoryUsers < ActiveRecord::Migration
  def change
    change_column :users, :category, :string, default: "guest"
  end
end
