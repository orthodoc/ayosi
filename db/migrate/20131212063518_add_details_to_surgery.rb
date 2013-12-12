class AddDetailsToSurgery < ActiveRecord::Migration
  def change
    add_column :surgeries, :category, :string
    add_column :surgeries, :side, :boolean
    add_column :surgeries, :region, :string
    add_column :surgeries, :surgeon, :string
  end
end
