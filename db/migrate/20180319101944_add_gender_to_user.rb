class AddGenderToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :gender, index: true
  end
end
