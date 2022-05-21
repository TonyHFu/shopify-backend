class Order < ApplicationRecord
  after_create :adjust_quantity

  has_many :order_items

  monetize :total_cents, numericality: true

  private

  def adjust_quantity
    order_items.each do |item|
      product = Product.find(item.product_id)
      product.quantity -= item.quantity
      product.save!
end
