class AddFkAddressToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :address, index: true
  end
end
