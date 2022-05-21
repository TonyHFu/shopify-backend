class CreateOrders < ActiveRecord::Migration[7.0]
	def change
		create_table :orders do |t|
			t.integer :total_cents

			t.timestamps null: false
		end
	end
end
