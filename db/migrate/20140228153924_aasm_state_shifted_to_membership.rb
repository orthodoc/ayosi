class AasmStateShiftedToMembership < ActiveRecord::Migration
  def change
    remove_column :designations, :aasm_state
    add_column :memberships, :aasm_state, :string
  end
end
