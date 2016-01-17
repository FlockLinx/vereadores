class AddFullNameToStates < ActiveRecord::Migration
  def change
    add_column :states, :full_name, :string
  end
end
