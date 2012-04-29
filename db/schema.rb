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

ActiveRecord::Schema.define(:version => 20100303082337) do

  create_table "clients", :force => true do |t|
    t.string "phone", :null => false
    t.string "email"
  end

  add_index "clients", ["phone"], :name => "index_clients_on_phone", :unique => true

  create_table "enquiries", :force => true do |t|
    t.integer  "client_id",  :null => false
    t.integer  "message_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enquiries", ["client_id"], :name => "index_enquiries_on_client_id"
  add_index "enquiries", ["message_id"], :name => "index_enquiries_on_message_id"

  create_table "messages", :force => true do |t|
    t.string   "keyword",       :null => false
    t.string   "sms_body"
    t.text     "email_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_subject"
  end

  add_index "messages", ["keyword"], :name => "index_messages_on_keyword", :unique => true

end
