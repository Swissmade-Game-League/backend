class AddTeamDevToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :team_name, :string
    add_column :users, :dev, :boolean, :default => false
  end
end
