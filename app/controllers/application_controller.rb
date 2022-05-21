class ApplicationController < ActionController::Base
	private

	def cart
		@cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
	end
	helper_method :cart

	def cart_details
		@cart_details ||=
			Product
				.where(id: cart.keys)
				.map { |product| { product: product, quantity: cart[product.id.to_s] } }
	end
	helper_method :cart_details

	def cart_subtotal_cents
		cart_details.map { |entry| entry[:product].price_cents * entry[:quantity] }
			.sum
	end
	helper_method :cart_subtotal_cents

	def update_cart(new_cart)
		cookies[:cart] = {
			value: JSON.generate(new_cart),
			expires: 10.days.from_now,
		}
		cookies[:cart]
	end
end
