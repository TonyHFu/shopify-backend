class CartsController < ApplicationController
	def show; end

	def add_item
		product_id = params[:product_id].to_s

		product = Product.find(params[:product_id])

		requested_amount = (cart[product_id] || 0)

		if requested_amount >= product.quantity
			flash[:notice] = 'Not enough in stock to add to cart'
		else
			modify_cart_delta(product_id, +1)
			flash[:notice] = 'Successfully added item to cart'
		end
		respond_to { |format| format.html { redirect_back fallback_location: '/' } }
	end

	def remove_item
		product_id = params[:product_id].to_s
		modify_cart_delta(product_id, -1)

		flash[:notice] = 'Successfully removed item from cart'
		redirect_back fallback_location: '/'
	end

	private

	def modify_cart_delta(product_id, delta)
		cart[product_id] = (cart[product_id] || 0) + delta
		cart.delete(product_id) if cart[product_id] < 1
		update_cart cart
	end
end
