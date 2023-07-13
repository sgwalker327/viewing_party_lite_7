class AddRoleToUserParties < ActiveRecord::Migration[7.0]
  def change
    add_column :user_parties, :role, :integer
  end
end
