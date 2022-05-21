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

	# GET /orders/1/edit
	def edit; end

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

	# PATCH/PUT /orders/1 or /orders/1.json
	def update
		respond_to do |format|
			if @order.update(order_params)
				format.html do
					redirect_to order_url(@order),
					            notice: 'Order was successfully updated.'
				end
				format.json { render :show, status: :ok, location: @order }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json do
					render json: @order.errors, status: :unprocessable_entity
				end
			end
		end
	end

	# DELETE /orders/1 or /orders/1.json
	def destroy
		@order.destroy

		respond_to do |format|
			format.html do
				redirect_to orders_url, notice: 'Order was successfully destroyed.'
			end
			format.json { head :no_content }
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_order
		@order = Order.find(params[:id])
	end
end
