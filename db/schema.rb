# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_29_112103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batch_files", force: :cascade do |t|
    t.string "guid", null: false
    t.bigint "batch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["batch_id"], name: "index_batch_files_on_batch_id", unique: true
    t.index ["guid"], name: "index_batch_files_on_guid", unique: true
  end

  create_table "invoice_operations", force: :cascade do |t|
    t.string "ParcelCode", limit: 15, null: false
    t.integer "ItemQty", limit: 2
    t.decimal "ParcelPrice", precision: 7, scale: 2
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ParcelCode"], name: "index_invoice_operations_on_ParcelCode", unique: true
    t.index ["invoice_id"], name: "index_invoice_operations_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "InvoiceOperationNumber", precision: 9, null: false
    t.date "InvoiceOperationDate", null: false
    t.integer "CompanyCode", null: false
    t.bigint "batch_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["InvoiceOperationNumber"], name: "index_invoices_on_InvoiceOperationNumber", unique: true
    t.index ["batch_file_id"], name: "index_invoices_on_batch_file_id"
  end

  add_foreign_key "invoice_operations", "invoices"
  add_foreign_key "invoices", "batch_files"
end
