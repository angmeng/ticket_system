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

ActiveRecord::Schema.define(:version => 20121114175041) do

  create_table "agent_groups", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "agent_groups", ["code"], :name => "index_agent_groups_on_code", :unique => true

  create_table "branches", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "branches", ["code"], :name => "index_branches_on_code", :unique => true

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "register_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "phone",           :limit => 16
    t.string   "fax",             :limit => 16
    t.string   "email"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "companies", ["register_number"], :name => "index_companies_on_register_number", :unique => true

  create_table "departures", :force => true do |t|
    t.integer  "vessel_id"
    t.integer  "sales_quota",  :default => 100
    t.integer  "online_quota", :default => 0
    t.boolean  "custom_quota", :default => false
    t.boolean  "on_call",      :default => false
    t.integer  "status_id",    :default => 1
    t.boolean  "active",       :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "departures", ["vessel_id"], :name => "index_departures_on_vessel_id"

  create_table "jetties", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "jetties", ["code"], :name => "index_jetties_on_code", :unique => true

  create_table "routines", :force => true do |t|
    t.string   "code"
    t.integer  "departure_jetty_id"
    t.integer  "arrival_jetty_id"
    t.integer  "sequence_no"
    t.boolean  "active",             :default => true
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "routines", ["arrival_jetty_id"], :name => "index_routines_on_arrival_jetty_id"
  add_index "routines", ["departure_jetty_id"], :name => "index_routines_on_departure_jetty_id"

  create_table "schedules", :force => true do |t|
    t.string   "code"
    t.time     "departure_time"
    t.integer  "routine_id"
    t.integer  "sales_quota",    :default => 0
    t.integer  "online_quota",   :default => 0
    t.boolean  "active",         :default => true
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "schedules", ["code"], :name => "index_schedules_on_code", :unique => true
  add_index "schedules", ["routine_id"], :name => "index_schedules_on_routine_id"

  create_table "staff_routines", :force => true do |t|
    t.integer  "staff_id"
    t.integer  "routine_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "staff_routines", ["routine_id"], :name => "index_staff_routines_on_routine_id"
  add_index "staff_routines", ["staff_id"], :name => "index_staff_routines_on_staff_id"

  create_table "ticket_categories", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "ticket_categories", ["code"], :name => "index_ticket_categories_on_code", :unique => true

  create_table "tickets", :force => true do |t|
    t.integer  "routine_id"
    t.integer  "ticket_category_id"
    t.string   "code"
    t.string   "name"
    t.integer  "initial_number",                                            :default => 0
    t.decimal  "fare",                       :precision => 10, :scale => 2, :default => 0.0
    t.boolean  "inventory_count",                                           :default => true
    t.boolean  "required_passenger_details",                                :default => true
    t.date     "valid_from"
    t.date     "expired_at"
    t.boolean  "no_expired",                                                :default => false
    t.boolean  "active",                                                    :default => true
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
  end

  add_index "tickets", ["code"], :name => "index_tickets_on_code", :unique => true
  add_index "tickets", ["routine_id"], :name => "index_tickets_on_routine_id"
  add_index "tickets", ["ticket_category_id"], :name => "index_tickets_on_ticket_category_id"

  create_table "users", :force => true do |t|
    t.string   "username",               :default => "",   :null => false
    t.string   "fullname",               :default => ""
    t.string   "email",                  :default => ""
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "agent_group_id",         :default => 0
    t.integer  "branch_id",              :default => 0
    t.integer  "category_id",            :default => 0
    t.text     "address"
    t.string   "phone"
    t.string   "fax"
    t.text     "remark"
    t.boolean  "active",                 :default => true
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "users", ["agent_group_id"], :name => "index_users_on_agent_group_id"
  add_index "users", ["branch_id"], :name => "index_users_on_branch_id"
  add_index "users", ["category_id"], :name => "index_users_on_category_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "vessels", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "total_passenger", :default => 100
    t.integer  "total_crew",      :default => 0
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "vessels", ["code"], :name => "index_vessels_on_code", :unique => true

  create_table "warrants", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "address"
    t.string   "phone",      :limit => 16
    t.string   "fax",        :limit => 16
    t.string   "email"
    t.text     "remark"
    t.boolean  "active",                   :default => true
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "warrants", ["code"], :name => "index_warrants_on_code", :unique => true

end
