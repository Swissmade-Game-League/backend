class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :key
      t.belongs_to :payment, index: true
      t.timestamps
    end
  end
end
