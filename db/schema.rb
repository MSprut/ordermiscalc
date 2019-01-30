# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_29_090244) do

  create_table "accountant_preferences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.decimal "income_tax_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "eru_tax_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "manager_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "profit_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "overheads_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "tax_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.boolean "actual", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "calculations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customer_category_parameters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "customer_category_id"
    t.bigint "user_id"
    t.decimal "manager_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "profit_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "overheads_percent", precision: 5, scale: 2, default: "0.0", null: false
    t.boolean "actual", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_category_id"], name: "index_customer_category_parameters_on_customer_category_id"
    t.index ["user_id"], name: "index_customer_category_parameters_on_user_id"
  end

  create_table "equipment", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 127, default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipment_parameters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "equipment_id"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "lifetime", default: 0, null: false
    t.integer "power", default: 0, null: false
    t.boolean "actual", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "residual_price", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "standbay_power", default: 0, null: false
    t.boolean "depreciation_type", default: false, null: false
    t.index ["equipment_id"], name: "index_equipment_parameters_on_equipment_id"
  end

  create_table "inventories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "unit_id"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["unit_id"], name: "index_inventories_on_unit_id"
  end

  create_table "inventory_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_inventory_categories_on_ancestry"
  end

  create_table "inventory_categories_inventories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "inventory_category_id"
    t.bigint "inventory_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_category_id"], name: "index_inventory_categories_inventories_on_inventory_category_id"
    t.index ["inventory_id"], name: "index_inventory_categories_inventories_on_inventory_id"
  end

  create_table "inventory_parameters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "inventory_id"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "margin", precision: 5, scale: 2, default: "0.0", null: false
    t.boolean "actual", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_id"], name: "index_inventory_parameters_on_inventory_id"
  end

  create_table "position_salaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "position_id"
    t.decimal "salary", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "actual", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "accountant_preference_id"
    t.index ["accountant_preference_id"], name: "index_position_salaries_on_accountant_preference_id"
    t.index ["position_id"], name: "index_position_salaries_on_position_id"
  end

  create_table "positions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 127, default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 127, default: "", null: false
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "inventory_categories_inventories", "inventories"
  add_foreign_key "inventory_categories_inventories", "inventory_categories"
  add_foreign_key "position_salaries", "accountant_preferences"
end
