class Product < ApplicationRecord
	monetize :price_cents, numericality: true

	validates :name, presence: true
	validates :price, presence: true
	validates :quantity, presence: true
end
