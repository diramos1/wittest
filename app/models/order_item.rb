class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates_presence_of :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :product
  validates_presence_of :order

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  def update_unit_price(price)
    self[:last_unit_price] = self[:unit_price]
    self[:unit_price] = price
  end

  private

  def finalize
    self[:last_unit_price] = unit_price unless self[:last_unit_price]
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
