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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130603123720) do

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.string   "hash_token", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "channels", ["hash_token"], :name => "index_channels_on_hash_token", :unique => true

  create_table "channels_streams", :id => false, :force => true do |t|
    t.integer "stream_id"
    t.integer "channel_id"
  end

  create_table "streams", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "desc"
    t.string   "hash_token",                                             :null => false
    t.decimal  "lat",                    :precision => 18, :scale => 12
    t.decimal  "lng",                    :precision => 18, :scale => 12
    t.string   "geo_reference"
    t.datetime "started_on"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  add_index "streams", ["hash_token"], :name => "index_streams_on_hash_token", :unique => true

end
