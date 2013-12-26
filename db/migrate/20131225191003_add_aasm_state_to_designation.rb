class AddAasmStateToDesignation < ActiveRecord::Migration
  def change
    add_column :designations, :aasm_state, :string
  end
end
