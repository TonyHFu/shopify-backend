class CartsController < ApplicationController
	def show
		puts cart.count
		render '/carts/error' if cart.count == 0
	end

	def add_item
		product_id = params[:product_id].to_s
		modify_cart_delta(product_id, +1)

		redirect_back(fallback_location: '/')
	end

	def remove_item
		product_id = params[:product_id].to_s
		modify_cart_delta(product_id, -1)

		redirect_back(fallback_location: '/')
	end

	private

	def modify_cart_delta(product_id, delta)
		cart[product_id] = (cart[product_id] || 0) + delta
		cart.delete(product_id) if cart[product_id] < 1
		update_cart cart
	end
end
