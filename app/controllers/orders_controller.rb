class OrdersController < ApplicationController
	before_action :set_order, only: %i[show edit update destroy]

	# GET /orders or /orders.json
	def index
		@orders = Order.all
	end

	# GET /orders/1 or /orders/1.json
	def show
		@order = Order.find(params[:id])
	end

	# POST /orders or /orders.json
	def create
		@order = Order.new(total_cents: cart_subtotal_cents)
		cart_details.each do |item|
			product = item[:product]
			quantity = item[:quantity]
			@order.order_items.new(
				product: product,
				quantity: quantity,
				item_price_cents: product.price,
				total_price_cents: product.price * quantity,
			)
		end

		respond_to do |format|
			if @order.save
				empty_cart!
				format.html do
					redirect_to order_url(@order),
					            notice: 'Order was successfully created.'
				end
				format.json { render :show, status: :created, location: @order }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json do
					render json: @order.errors, status: :unprocessable_entity
				end
			end
		end
	end

	private

	# To empty cart once order accepted
	def empty_cart!
		update_cart({})
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_order
		@order = Order.find(params[:id])
	end
end
