class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.float :amount
      t.boolean :paid
      t.string :token
      t.belongs_to :user, index: true
      t.timestamps
    end
    add_column :users, :remote_id, :string
  end
end
