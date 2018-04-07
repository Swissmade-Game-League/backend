class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.timestamps
    end
    add_reference :states, :country, index: true
  end
end
