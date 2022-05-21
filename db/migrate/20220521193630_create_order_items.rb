class CreateOrderItems < ActiveRecord::Migration[7.0]
	def change
		create_table :order_items do |t|
			t.references :order, index: true, foreign_key: true
			t.references :proudct, index: true, foreign_key: true
			t.integer :quantity
			t.integer :item_price_cents
			t.integer :total_price_cents
			t.timestamps null: false
		end
	end
end
