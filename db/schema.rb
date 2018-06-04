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

ActiveRecord::Schema.define(version: 20180602212606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "pgcrypto"

  create_table "agreements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "neighborhood_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["neighborhood_id"], name: "index_agreements_on_neighborhood_id"
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "description"
    t.uuid "neighborhood_id", null: false
    t.string "attachment"
    t.string "file_type"
    t.integer "file_size"
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_documents_on_ancestry"
    t.index ["data"], name: "index_documents_on_data", using: :gin
    t.index ["neighborhood_id"], name: "index_documents_on_neighborhood_id"
  end

  create_table "documents_relations", force: :cascade do |t|
    t.uuid "document_id", null: false
    t.string "relatable_type"
    t.uuid "relatable_id", null: false
    t.uuid "responsible_id", null: false
    t.datetime "created_at"
    t.index ["document_id"], name: "index_documents_relations_on_document_id"
    t.index ["relatable_type", "relatable_id"], name: "index_documents_relations_on_relatable_type_and_relatable_id"
    t.index ["responsible_id"], name: "index_documents_relations_on_responsible_id"
  end

  create_table "meetings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "neighborhood_id", null: false
    t.datetime "date"
    t.string "lookup_address"
    t.geography "lookup_coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.text "objectives"
    t.text "minute"
    t.string "organizer"
    t.string "participants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lookup_coordinates"], name: "index_meetings_on_lookup_coordinates", using: :gist
    t.index ["neighborhood_id"], name: "index_meetings_on_neighborhood_id"
  end

  create_table "meetings_works", id: false, force: :cascade do |t|
    t.uuid "meeting_id"
    t.uuid "work_id"
    t.index ["meeting_id", "work_id"], name: "index_meetings_works_on_meeting_id_and_work_id"
    t.index ["meeting_id"], name: "index_meetings_works_on_meeting_id"
    t.index ["work_id"], name: "index_meetings_works_on_work_id"
  end

  create_table "neighborhoods", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "lookup_address"
    t.geography "lookup_coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.geography "geo_geometry", limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "urbanization", default: false
    t.jsonb "extras", default: {}
    t.float "urbanization_score"
    t.index ["geo_geometry"], name: "index_neighborhoods_on_geo_geometry", using: :gist
    t.index ["geometry"], name: "index_neighborhoods_on_geometry", using: :gist
    t.index ["lookup_coordinates"], name: "index_neighborhoods_on_lookup_coordinates", using: :gist
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "owner_type", null: false
    t.uuid "owner_id", null: false
    t.uuid "uploader_id", null: false
    t.string "image"
    t.string "original_filename"
    t.string "content_type"
    t.integer "file_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_photos_on_owner_type_and_owner_id"
  end

  create_table "profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.uuid "taggable_id"
    t.string "tagger_type"
    t.uuid "tagger_id"
    t.string "context"
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "entity_type"
    t.uuid "entity_id"
    t.integer "roles_mask"
    t.jsonb "settings", default: {}, null: false
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.boolean "active", default: false
    t.boolean "approved", default: false
    t.boolean "confirmed", default: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["entity_type", "entity_id"], name: "index_users_on_entity_type_and_entity_id"
    t.index ["perishable_token"], name: "index_users_on_perishable_token", unique: true
    t.index ["persistence_token"], name: "index_users_on_persistence_token", unique: true
    t.index ["roles_mask"], name: "index_users_on_roles_mask"
    t.index ["settings"], name: "index_users_on_settings", using: :gin
    t.index ["single_access_token"], name: "index_users_on_single_access_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "works", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "neighborhood_id", null: false
    t.string "name"
    t.text "description"
    t.string "status"
    t.date "start_date"
    t.date "estimated_end_date"
    t.date "end_date"
    t.string "lookup_address"
    t.geography "lookup_coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.geography "geo_geometry", limit: {:srid=>4326, :type=>"geometry", :geographic=>true}
    t.geometry "geometry", limit: {:srid=>0, :type=>"geometry"}
    t.string "budget"
    t.string "manager"
    t.text "execution_plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.index ["geo_geometry"], name: "index_works_on_geo_geometry", using: :gist
    t.index ["geometry"], name: "index_works_on_geometry", using: :gist
    t.index ["lookup_coordinates"], name: "index_works_on_lookup_coordinates", using: :gist
    t.index ["neighborhood_id"], name: "index_works_on_neighborhood_id"
  end

end
