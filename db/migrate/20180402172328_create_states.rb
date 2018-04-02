class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :name
      t.timestamps
    end
    add_reference :localities, :state, index: true
  end
end
