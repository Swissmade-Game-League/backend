class AddFkLocalityToAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :locality, index: true
  end
end
