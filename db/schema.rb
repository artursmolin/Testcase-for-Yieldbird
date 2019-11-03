# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_191_103_072_532) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'divisions', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'tournament_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tournament_id'], name: 'index_divisions_on_tournament_id'
  end

  create_table 'matches', force: :cascade do |t|
    t.string 'result', null: false
    t.string 'winner', null: false
    t.string 'stage', null: false
    t.bigint 'home_team_id', null: false
    t.bigint 'guest_team_id', null: false
    t.bigint 'tournament_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['guest_team_id'], name: 'index_matches_on_guest_team_id'
    t.index ['home_team_id'], name: 'index_matches_on_home_team_id'
    t.index ['tournament_id'], name: 'index_matches_on_tournament_id'
  end

  create_table 'teams', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'division_points', default: 0
    t.bigint 'tournament_id', null: false
    t.bigint 'division_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['division_id'], name: 'index_teams_on_division_id'
    t.index ['tournament_id'], name: 'index_teams_on_tournament_id'
  end

  create_table 'tournaments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'winner'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
