# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100312131810) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  create_table "changes", :force => true do |t|
    t.text     "description"
    t.string   "email"
    t.string   "author"
    t.boolean  "done"
    t.datetime "created_at"
    t.integer  "place_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "contents"
    t.datetime "date_time"
    t.string   "autor"
    t.string   "email"
    t.integer  "place_id"
    t.datetime "created_at"
  end

  create_table "dishes", :force => true do |t|
    t.float    "price"
    t.boolean  "is_available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "place_id"
    t.integer  "weight"
    t.integer  "pieces"
    t.string   "description"
  end

  create_table "editors", :force => true do |t|
    t.boolean  "admin"
    t.string   "hashed_password"
    t.string   "login"
    t.string   "email"
    t.datetime "created_at"
    t.string   "name_surname"
    t.boolean  "active"
  end

  create_table "histories", :force => true do |t|
    t.datetime "created_at"
    t.integer  "place_id"
    t.integer  "editor_id"
    t.string   "what"
  end

  create_table "news", :force => true do |t|
    t.text     "contents"
    t.integer  "editor_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "for_editors"
    t.boolean  "for_guests"
  end

  create_table "open_hours", :force => true do |t|
    t.string  "from_day"
    t.string  "to_day"
    t.time    "from_hour"
    t.time    "to_hour"
    t.integer "place_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "filename"
    t.integer  "size"
    t.string   "content_type"
    t.string   "thumbnail"
    t.integer  "parent_id"
    t.integer  "height"
    t.integer  "width"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.text     "description", :limit => 255
    t.string   "street"
    t.string   "name"
    t.boolean  "active"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "deleted",                    :default => false
  end

  create_table "places_tags", :id => false, :force => true do |t|
    t.integer "place_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "rate"
    t.datetime "created_at"
    t.integer  "place_id"
    t.string   "ip"
  end

end
