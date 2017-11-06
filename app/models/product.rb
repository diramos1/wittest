class Product < ApplicationRecord
  validates_presence_of :name, :price

  has_many :order_items

  after_save :update_in_progress_orders

  def update_in_progress_orders
    self.order_items.each do |oi|
      oi.update_unit_price(self.price)
      oi.save
      oi.order.save
    end
  end
end
