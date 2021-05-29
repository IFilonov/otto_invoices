# 1. rails generate model invoice_operation ParcelCode:string{15}:index  ItemQty:integer{2} 'ParcelPrice:decimal{7,2}' invoice:references
# 2. add 'null: false' for column ParcelCode
class CreateInvoiceOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_operations do |t|
      t.string :ParcelCode, limit: 15, null: false
      t.integer :ItemQty, limit: 2
      t.decimal :ParcelPrice, precision: 7, scale: 2
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
    add_index :invoice_operations, :ParcelCode
  end
end
