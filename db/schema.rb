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

ActiveRecord::Schema.define(:version => 20130112193405) do

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
    t.boolean  "active",                                          :default => true
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.decimal  "basic_commission", :precision => 10, :scale => 2, :default => 10.0
    t.decimal  "agent_commission", :precision => 10, :scale => 2, :default => 10.0
  end

  add_index "branches", ["code"], :name => "index_branches_on_code", :unique => true

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "register_number"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "phone",                      :limit => 16
    t.string   "fax",                        :limit => 16
    t.string   "email"
    t.datetime "created_at",                                                                               :null => false
    t.datetime "updated_at",                                                                               :null => false
    t.integer  "branch_id"
    t.decimal  "discount_on_two_way_ticket",               :precision => 10, :scale => 2, :default => 5.0
    t.integer  "last_voucher_number",                                                     :default => 0
    t.integer  "last_receipt_number",                                                     :default => 0
  end

  add_index "companies", ["register_number"], :name => "index_companies_on_register_number", :unique => true

  create_table "departures", :force => true do |t|
    t.integer  "vessel_id"
    t.integer  "sales_quota",             :default => 100
    t.integer  "online_quota",            :default => 0
    t.boolean  "custom_quota",            :default => false
    t.boolean  "on_call",                 :default => false
    t.integer  "status_id",               :default => 1
    t.boolean  "active",                  :default => true
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "extra_trip"
    t.integer  "routine_id"
    t.date     "date"
    t.time     "time"
    t.integer  "online_sales",            :default => 0
    t.integer  "counter_sales",           :default => 0
    t.integer  "available_online_sales",  :default => 0
    t.integer  "available_counter_sales", :default => 0
  end

  add_index "departures", ["routine_id"], :name => "index_departures_on_routine_id"
  add_index "departures", ["vessel_id"], :name => "index_departures_on_vessel_id"

  create_table "jetties", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.boolean  "active",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "jetties", ["code"], :name => "index_jetties_on_code", :unique => true

  create_table "order_item_details", :force => true do |t|
    t.integer  "order_item_id",                                     :default => 0
    t.string   "serial_number"
    t.integer  "ticket_status_id",                                  :default => 0
    t.decimal  "fare",               :precision => 10, :scale => 2, :default => 0.0
    t.integer  "ticket_category_id",                                :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id",                                                         :null => false
    t.integer  "departure_id",                                                     :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.integer  "routine_id"
    t.integer  "number_of_adult",                                 :default => 0
    t.integer  "number_of_kid",                                   :default => 0
    t.decimal  "adult_fare",       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "kid_fare",         :precision => 10, :scale => 2, :default => 0.0
    t.integer  "travel_type_id",                                  :default => 0
    t.integer  "number_of_infant",                                :default => 0
    t.integer  "arrival_id",                                      :default => 0
    t.integer  "status_id",                                       :default => 0
    t.decimal  "infant_fare",      :precision => 10, :scale => 2, :default => 0.0
  end

  add_index "order_items", ["departure_id"], :name => "index_order_items_on_departure_id"
  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["routine_id"], :name => "index_order_items_on_routine_id"
  add_index "order_items", ["travel_type_id"], :name => "index_order_items_on_travel_type_id"

  create_table "orders", :force => true do |t|
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "buyer_type_id"
    t.integer  "payment_type_id"
    t.integer  "free_tickets",                                            :default => 0
    t.decimal  "discount",                 :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "extra_charges",            :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "amount_tender",            :precision => 10, :scale => 2, :default => 0.0
    t.text     "remark"
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
    t.integer  "travel_type_id",                                          :default => 0
    t.integer  "total_passenger",                                         :default => 0
    t.boolean  "bypass_credit",                                           :default => false
    t.integer  "bypass_credit_manager_id",                                :default => 0
  end

  add_index "orders", ["buyer_id", "buyer_type_id"], :name => "index_orders_on_buyer_id_and_buyer_type_id"
  add_index "orders", ["payment_type_id"], :name => "index_orders_on_payment_type_id"
  add_index "orders", ["seller_id"], :name => "index_orders_on_seller_id"
  add_index "orders", ["travel_type_id"], :name => "index_orders_on_travel_type_id"

  create_table "passengers", :force => true do |t|
    t.string   "title"
    t.string   "fullname"
    t.date     "date_of_birth"
    t.string   "travel_document"
    t.string   "issuing_country"
    t.string   "document_no"
    t.date     "expiration_date"
    t.integer  "order_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "passengers", ["order_id"], :name => "index_passengers_on_order_id"

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
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "weekday"
    t.date     "departure_date"
    t.boolean  "extra_trip",     :default => false
  end

  add_index "schedules", ["code"], :name => "index_schedules_on_code", :unique => true
  add_index "schedules", ["extra_trip"], :name => "index_schedules_on_extra_trip"
  add_index "schedules", ["routine_id"], :name => "index_schedules_on_routine_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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
    t.integer  "type_id",                      :null => false
  end

  add_index "ticket_categories", ["code"], :name => "index_ticket_categories_on_code", :unique => true
  add_index "ticket_categories", ["type_id"], :name => "index_ticket_categories_on_type_id"

  create_table "tickets", :force => true do |t|
    t.integer  "routine_id"
    t.integer  "ticket_category_id"
    t.string   "code"
    t.string   "name"
    t.integer  "initial_number",                                            :default => 0
    t.decimal  "fare",                       :precision => 10, :scale => 2, :default => 0.0
    t.boolean  "inventory_count",                                           :default => true
    t.boolean  "required_passenger_details",                                :default => true
    t.boolean  "no_expired",                                                :default => false
    t.boolean  "active",                                                    :default => true
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.integer  "valid_days",                                                :default => 30
  end

  add_index "tickets", ["code"], :name => "index_tickets_on_code", :unique => true
  add_index "tickets", ["routine_id"], :name => "index_tickets_on_routine_id"
  add_index "tickets", ["ticket_category_id"], :name => "index_tickets_on_ticket_category_id"

  create_table "topup_credits", :force => true do |t|
    t.integer  "agent_id"
    t.decimal  "amount",     :precision => 10, :scale => 2, :default => 0.0
    t.text     "remark"
    t.integer  "staff_id"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "topup_credits", ["agent_id"], :name => "index_topup_credits_on_agent_id"
  add_index "topup_credits", ["staff_id"], :name => "index_topup_credits_on_staff_id"

  create_table "users", :force => true do |t|
    t.string   "username",                                              :default => "",   :null => false
    t.string   "fullname",                                              :default => ""
    t.string   "email",                                                 :default => ""
    t.string   "encrypted_password",                                    :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "agent_group_id",                                        :default => 0
    t.integer  "branch_id",                                             :default => 0
    t.integer  "category_id",                                           :default => 0
    t.text     "address"
    t.string   "phone"
    t.string   "fax"
    t.text     "remark"
    t.boolean  "active",                                                :default => true
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.decimal  "credit",                 :precision => 10, :scale => 2, :default => 0.0
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
