# 1. rails generate model invoice2 'InvoiceOperationNumber:decimal{9,0}:uniq' InvoiceOperationDate:date CompanyCode:integer{4} batch_file:references
# 2. add 'null: false' for InvoiceOperationNumber, InvoiceOperationDate, CompanyCode
class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.decimal :InvoiceOperationNumber, precision: 9, scale: 0, null: false
      t.date :InvoiceOperationDate, null: false
      t.integer :CompanyCode, limit: 4, null: false
      t.references :batch_file, null: false, foreign_key: true

      t.timestamps
    end
    add_index :invoices, :InvoiceOperationNumber, unique: true
  end
end
