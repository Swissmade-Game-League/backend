class AddFavoriteGameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :favorite_game, :string
  end
end
