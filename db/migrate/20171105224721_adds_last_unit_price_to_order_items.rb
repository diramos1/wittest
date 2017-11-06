class AddsLastUnitPriceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :last_unit_price, :decimal, precision: 12, scale: 2
  end
end
