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

ActiveRecord::Schema[8.1].define(version: 2026_08_30_120000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "episode_states", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "episode_id", null: false
    t.datetime "seen_at", precision: nil
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["episode_id"], name: "index_episode_states_on_episode_id"
    t.index ["user_id"], name: "index_episode_states_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "first_aired"
    t.integer "number"
    t.bigint "season_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "show_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["show_id"], name: "index_favourites_on_show_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "filaments", force: :cascade do |t|
    t.string "color_hex", null: false
    t.string "color_name", null: false
    t.datetime "created_at", null: false
    t.string "natural_color_sort_key", null: false
    t.bigint "product_id", null: false
    t.datetime "updated_at", null: false
    t.index ["natural_color_sort_key"], name: "index_filaments_on_natural_color_sort_key"
    t.index ["product_id"], name: "index_filaments_on_product_id"
  end

  create_table "materials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_materials_on_name", unique: true
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "application_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.bigint "resource_owner_id", null: false
    t.datetime "revoked_at", precision: nil
    t.string "scopes", default: "", null: false
    t.string "token", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "application_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "expires_in"
    t.string "previous_refresh_token", default: "", null: false
    t.string "refresh_token"
    t.bigint "resource_owner_id"
    t.datetime "revoked_at", precision: nil
    t.string "scopes"
    t.string "token", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.string "secret", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "oidc_identities", force: :cascade do |t|
    t.jsonb "claims", default: {}, null: false
    t.datetime "created_at", null: false
    t.string "email"
    t.string "issuer", null: false
    t.string "name"
    t.string "picture"
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["provider", "issuer", "uid"], name: "index_oidc_identities_on_provider_and_issuer_and_uid", unique: true
    t.index ["user_id", "provider", "issuer"], name: "index_oidc_identities_on_user_id_and_provider_and_issuer", unique: true
    t.index ["user_id"], name: "index_oidc_identities_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.datetime "created_at", null: false
    t.bigint "material_id", null: false
    t.string "name", null: false
    t.integer "spool_weight_grams", null: false
    t.datetime "updated_at", null: false
    t.bigint "variant_id", null: false
    t.integer "weight_grams", null: false
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["material_id"], name: "index_products_on_material_id"
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["variant_id"], name: "index_products_on_variant_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "number"
    t.bigint "show_id", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_seasons_on_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.boolean "block_sync", default: false, null: false
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "imdb_ref"
    t.string "language", default: "en", null: false
    t.string "network"
    t.text "overview"
    t.decimal "rating", precision: 3, scale: 1, default: "0.0", null: false
    t.string "slug", default: -> { "md5((random())::text)" }, null: false
    t.string "thetvdb_ref"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_shows_on_slug", unique: true
  end

  create_table "spools", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.bigint "filament_id", null: false
    t.integer "gross_weight_grams"
    t.string "inventory_tag"
    t.boolean "ovp", default: false, null: false
    t.boolean "refill_only", default: false, null: false
    t.integer "remaining_weight_grams", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index "lower((inventory_tag)::text)", name: "index_spools_on_lower_inventory_tag", unique: true
    t.index ["filament_id"], name: "index_spools_on_filament_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "show_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["show_id"], name: "index_subscriptions_on_show_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_variants_on_name", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "event", null: false
    t.bigint "item_id", null: false
    t.string "item_type", null: false
    t.jsonb "object"
    t.jsonb "object_changes"
    t.bigint "transaction_id"
    t.string "whodunnit"
    t.index ["created_at"], name: "index_versions_on_created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
    t.index ["whodunnit"], name: "index_versions_on_whodunnit"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "episode_states", "episodes"
  add_foreign_key "episode_states", "users"
  add_foreign_key "episodes", "seasons"
  add_foreign_key "favourites", "shows"
  add_foreign_key "favourites", "users"
  add_foreign_key "filaments", "products"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "oidc_identities", "users"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "materials"
  add_foreign_key "products", "variants"
  add_foreign_key "seasons", "shows"
  add_foreign_key "spools", "filaments"
  add_foreign_key "subscriptions", "shows"
  add_foreign_key "subscriptions", "users"
end
