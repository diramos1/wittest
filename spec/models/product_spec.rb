require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should have_many(:order_items) }

  context "after save" do
    let(:product) { create :product }
    let(:order_item) { create :order_item, product: product }

    before do 
      order_item
      product.reload
      product.update(price: Faker::Number.decimal(2))
      order_item.reload
    end

    it "should update order_items value" do
      expect(order_item.unit_price).to be_eql product.price
    end

    it "should keep last_unit_price" do
      expect(order_item.last_unit_price).to_not be_eql order_item.unit_price
    end
  end
end
