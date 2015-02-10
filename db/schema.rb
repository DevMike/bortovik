# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140823202612) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "car_brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "slug"
  end

  add_index "car_brands", ["name"], name: "index_car_brands_on_name", using: :btree

  create_table "car_feature_car_modifications", force: :cascade do |t|
    t.integer "car_feature_id"
    t.integer "car_modification_id"
    t.string  "value"
  end

  add_index "car_feature_car_modifications", ["car_feature_id"], name: "index_car_feature_car_modifications_on_car_feature_id", using: :btree
  add_index "car_feature_car_modifications", ["car_modification_id"], name: "index_car_feature_car_modifications_on_car_modification_id", using: :btree

  create_table "car_feature_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "car_feature_categories", ["name"], name: "index_car_feature_categories_on_name", using: :btree

  create_table "car_features", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_feature_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "car_features", ["car_feature_category_id"], name: "index_car_features_on_car_feature_category_id", using: :btree
  add_index "car_features", ["name"], name: "index_car_features_on_name", using: :btree

  create_table "car_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "slug"
  end

  add_index "car_models", ["car_brand_id"], name: "index_car_models_on_car_brand_id", using: :btree
  add_index "car_models", ["name"], name: "index_car_models_on_name", using: :btree

  create_table "car_modifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "slug"
  end

  add_index "car_modifications", ["car_model_id"], name: "index_car_modifications_on_car_model_id", using: :btree
  add_index "car_modifications", ["name"], name: "index_car_modifications_on_name", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settlements", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settlements", ["region_id"], name: "index_settlements_on_region_id", using: :btree

  create_table "user_vehicles", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.integer  "user_id"
    t.date     "date_of_purchase"
    t.date     "date_of_sale"
    t.integer  "mileage_on_purchase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_vehicles", ["user_id"], name: "index_user_vehicles_on_user_id", using: :btree
  add_index "user_vehicles", ["vehicle_id"], name: "index_user_vehicles_on_vehicle_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "settlement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "preferred_currency"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "icq"
    t.string   "skype"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "provider"
    t.string   "url"
    t.string   "gender"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["settlement_id"], name: "index_users_on_settlement_id", using: :btree
  add_index "users", ["url"], name: "index_users_on_url", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.integer  "car_modification_id"
    t.float    "engine_volume"
    t.string   "transmission"
    t.string   "color"
    t.integer  "mileage"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vin"
    t.integer  "release_year"
  end

  add_index "vehicles", ["car_modification_id"], name: "index_vehicles_on_car_modification_id", using: :btree

end
