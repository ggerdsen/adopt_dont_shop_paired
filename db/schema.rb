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

ActiveRecord::Schema.define(version: 20200712180012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_applications", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "phone_number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_adoption_applications", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "adoption_application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adoption_application_id"], name: "index_pet_adoption_applications_on_adoption_application_id"
    t.index ["pet_id"], name: "index_pet_adoption_applications_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.integer "approximate_age"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "shelter_id"
    t.string "description"
    t.string "status"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelter_reviews", force: :cascade do |t|
    t.string "title"
    t.integer "rating"
    t.string "content"
    t.string "picture"
    t.bigint "shelter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shelter_id"], name: "index_shelter_reviews_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pet_adoption_applications", "adoption_applications"
  add_foreign_key "pet_adoption_applications", "pets"
  add_foreign_key "pets", "shelters"
  add_foreign_key "shelter_reviews", "shelters"
end
