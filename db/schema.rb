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

ActiveRecord::Schema[7.1].define(version: 2023_11_26_201239) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.bigint "merchant_id"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "amount_without_tax", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "year"
    t.integer "week"
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_disbursements_on_merchant_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "email", null: false
    t.string "reference", null: false
    t.date "live_on", null: false
    t.string "disbursement_frequency"
    t.decimal "minimum_monthly_fee", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_merchants_on_email", unique: true
    t.index ["reference"], name: "index_merchants_on_reference", unique: true
  end

  create_table "monthly_fees", force: :cascade do |t|
    t.bigint "merchant_id"
    t.integer "year"
    t.integer "month"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_monthly_fees_on_merchant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "merchant_reference"
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "completed_at"
    t.bigint "disbursement_id"
    t.index ["disbursement_id"], name: "index_orders_on_disbursement_id"
    t.index ["identifier"], name: "index_orders_on_identifier", unique: true
  end

end
