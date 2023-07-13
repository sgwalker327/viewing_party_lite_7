class AddDefaultToRole < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_parties, :role, 0
  end
end
