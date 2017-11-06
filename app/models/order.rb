class Order < ApplicationRecord
    enum status: [:in_progress, :shipped, :cancelled]

    belongs_to :user, optional: true
    has_many :order_items, dependent: :destroy

    before_create :set_order_status
    before_save :set_total

    def valid_ttl?
        self.updated_at > 2.days.ago
    end

    private

    def set_order_status
        self.status = :in_progress
    end

    def set_total
        self.total = order_items.sum { |oi| oi.quantity * oi.unit_price }
    end
end
