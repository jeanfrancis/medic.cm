class AddStatusToCase < ActiveRecord::Migration[5.2]
  def change
    add_column :cases, :status, :string
  end
end
