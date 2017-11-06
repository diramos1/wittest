class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :status
      t.decimal :total, precision: 12, scale: 2

      t.timestamps
    end
  end
end
