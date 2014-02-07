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

ActiveRecord::Schema.define(version: 20140127141439) do

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "email"
    t.string   "phone"
    t.date     "last_contact"
    t.integer  "opportunity_id"
    t.integer  "recruiter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_contact_id"
  end

  add_index "contacts", ["opportunity_id"], name: "index_contacts_on_opportunity_id", using: :btree
  add_index "contacts", ["recruiter_id"], name: "index_contacts_on_recruiter_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "event_type"
    t.datetime "event_time"
    t.integer  "opportunity_id"
    t.integer  "recruiter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "google_calendar_id"
    t.string   "google_event_id"
  end

  add_index "events", ["opportunity_id"], name: "index_events_on_opportunity_id", using: :btree
  add_index "events", ["recruiter_id"], name: "index_events_on_recruiter_id", using: :btree

  create_table "google_clients", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity"
    t.text     "credentials"
    t.string   "google_calendar_id"
    t.string   "user_email"
  end

  create_table "opportunities", force: true do |t|
    t.string   "company"
    t.string   "position"
    t.datetime "phone_interview"
    t.datetime "on_site_interview"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recruiter_id"
    t.boolean  "phone_interview_scheduled"
    t.boolean  "on_site_interview_scheduled"
  end

  add_index "opportunities", ["recruiter_id"], name: "index_opportunities_on_recruiter_id", using: :btree
  add_index "opportunities", ["state_id"], name: "index_opportunities_on_state_id", using: :btree

  create_table "recruiters", force: true do |t|
    t.string   "company"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string  "state"
    t.integer "opportunity_id"
    t.integer "weight"
  end

  add_index "states", ["opportunity_id"], name: "index_states_on_opportunity_id", using: :btree

end
